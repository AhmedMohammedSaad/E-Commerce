import 'package:equatable/equatable.dart';
import '../models/simple_chat_model.dart';

/// حالات الدردشة المختلفة
abstract class SimpleChatState extends Equatable {
  const SimpleChatState();

  @override
  List<Object?> get props => [];
}

/// الحالة الأولية للدردشة
class ChatInitial extends SimpleChatState {
  const ChatInitial();
}

/// حالة تحميل الدردشة
class ChatLoading extends SimpleChatState {
  const ChatLoading();
}

/// حالة الدردشة المحملة بنجاح
class ChatLoaded extends SimpleChatState {
  final SimpleChat chat;
  final bool isTyping;
  // final bool isRecording; // معطل مؤقتاً
  // final bool isProcessingAudio; // معطل مؤقتاً

  const ChatLoaded({
    required this.chat,
    this.isTyping = false,
    // this.isRecording = false, // معطل مؤقتاً
    // this.isProcessingAudio = false, // معطل مؤقتاً
  });

  @override
  List<Object?> get props => [
        chat,
        isTyping,
        // isRecording, // معطل مؤقتاً
        // isProcessingAudio, // معطل مؤقتاً
      ];

  /// نسخ الحالة مع تحديث بعض القيم
  ChatLoaded copyWith({
    SimpleChat? chat,
    bool? isTyping,
    // bool? isRecording, // معطل مؤقتاً
    // bool? isProcessingAudio, // معطل مؤقتاً
  }) {
    return ChatLoaded(
      chat: chat ?? this.chat,
      isTyping: isTyping ?? this.isTyping,
      // isRecording: isRecording ?? this.isRecording, // معطل مؤقتاً
      // isProcessingAudio: isProcessingAudio ?? this.isProcessingAudio, // معطل مؤقتاً
    );
  }
}

/// حالة خطأ في الدردشة
class ChatError extends SimpleChatState {
  final String message;
  final SimpleChat? chat;

  const ChatError({
    required this.message,
    this.chat,
  });

  @override
  List<Object?> get props => [message, chat];
}

/// حالة عدم توفر مفتاح API
class ChatApiKeyMissing extends SimpleChatState {
  const ChatApiKeyMissing();
}

/// حالة تجاوز حصة الاستخدام
class ChatQuotaExceeded extends SimpleChatState {
  final SimpleChat? chat;
  final Duration? retryAfter;

  const ChatQuotaExceeded({
    this.chat,
    this.retryAfter,
  });

  @override
  List<Object?> get props => [chat, retryAfter];
}