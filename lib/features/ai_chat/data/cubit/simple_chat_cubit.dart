import 'package:bloc/bloc.dart';
import '../models/simple_chat_model.dart';
import '../services/simple_ai_service.dart';
import 'simple_chat_state.dart';

class SimpleChatCubit extends Cubit<SimpleChatState> {
  final SimpleAIService _ai;
  SimpleChatCubit(this._ai) : super(ChatInitial());

  /// تهيئة الدردشة
  Future<void> initializeChat() async {
    emit(ChatLoading());
    try {
      _ai.startNewChatSession();
      final chat = SimpleChat.newChat();
      emit(ChatLoaded(chat: chat, isTyping: false));
    } catch (_) {
      // ممكن تغيّرها لـ ChatError حسب منطقك، لكن UI عندك بيعرض شاشة خاصة لمفتاح API
      emit(const ChatApiKeyMissing());
    }
  }

  /// بدء جلسة جديدة مع مسح الرسائل
  Future<void> clearChat() async {
    emit(ChatLoading());
    try {
      _ai.startNewChatSession();
      final chat = SimpleChat.newChat();
      emit(ChatLoaded(chat: chat, isTyping: false));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  /// إعادة المحاولة بعد خطأ/Quota
  Future<void> retryAfterError() async {
    final prev = state;
    if (prev is ChatError && prev.chat != null) {
      emit(ChatLoaded(chat: prev.chat!, isTyping: false));
    } else if (prev is ChatQuotaExceeded && prev.chat != null) {
      emit(ChatLoaded(chat: prev.chat!, isTyping: false));
    } else {
      await initializeChat();
    }
  }

  /// إرسال رسالة نصية للمساعد
  Future<void> sendTextMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1) ضمان وجود محادثة صالحة
    final baseChat = await _ensureChatOrInit();
    if (baseChat == null) return;

    // هنحتفظ بـ nextChat خارج try/catch عشان ما نرجعش للقديم وقت الخطأ
    var nextChat = baseChat;

    try {
      // 2) أضف رسالة المستخدم
      final userMsg = ChatMessage.userText(text);
      nextChat = nextChat.addMessage(userMsg);

      emit(ChatLoaded(chat: nextChat, isTyping: true));

      // 3) احصل على ردّ Gemini
      final reply = await _ai.generateChatReply(text);

      // 4) أضف رسالة AI بالمحتوى الحقيقي
      nextChat = nextChat.addMessage(ChatMessage.aiReply(reply));

      emit(ChatLoaded(chat: nextChat, isTyping: false));
    } on AIServiceException catch (e) {
      // أضف رسالة خطأ ودّية
      final friendly = e.isQuotaExceeded
          ? 'تم تجاوز حصة الاستخدام. حاول لاحقاً.'
          : 'تعذر توليد رد بسبب إعدادات السلامة.\nمن فضلك أعد صياغة سؤالك بصيغة تقنية ومحايدة.';

      nextChat = nextChat.addMessage(ChatMessage.aiReply(friendly));

      if (e.isQuotaExceeded) {
        emit(ChatQuotaExceeded(chat: nextChat, retryAfter: e.retryAfter));
      } else {
        emit(ChatError(message: e.message, chat: nextChat));
      }
    } catch (e) {
      // أي خطأ عام: أضف رسالة خطأ ودّية
      nextChat = nextChat
          .addMessage(ChatMessage.aiReply('حدث خطأ غير متوقع. حاول مرة أخرى.'));
      emit(ChatError(message: e.toString(), chat: nextChat));
    }
  }

  /// ====== مساعدات خاصة بالكيوبت ======

  /// ضمان وجود محادثة جاهزة، أو تهيئتها إن لزم
  Future<SimpleChat?> _ensureChatOrInit() async {
    final current = state;
    if (current is ChatLoaded) return current.chat;
    if (current is ChatError && current.chat != null) return current.chat!;
    if (current is ChatQuotaExceeded && current.chat != null)
      return current.chat!;

    // لو مفيش محادثة، ابدأ واحدة جديدة ثم ارجعها
    await initializeChat();
    final after = state;
    if (after is ChatLoaded) return after.chat;

    emit(const ChatError(message: 'تعذر بدء الدردشة.'));
    return null;
  }

  /// استبدال آخر رسالة AI (عادةً فقاعة التفكير) بالنص الجديد
  SimpleChat _replaceLastAiMessage(SimpleChat chat, String newContent) {
    final msgs = List<ChatMessage>.from(chat.messages);
    final lastAiIndex =
        msgs.lastIndexWhere((m) => m.sender == MessageSender.ai);
    if (lastAiIndex != -1) {
      msgs[lastAiIndex] = msgs[lastAiIndex].copyWith(content: newContent);
      return chat.copyWith(messages: msgs);
    }
    // لو لأي سبب ملقيناش رسالة AI، أضف واحدة جديدة
    return chat.addMessage(ChatMessage.aiReply(newContent));
  }
}
