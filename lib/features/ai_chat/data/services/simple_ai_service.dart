import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:advanced_app/core/config/api_config.dart';

/// استثناء موحّد للخدمة
class AIServiceException implements Exception {
  final String message;
  final bool isQuotaExceeded;
  final Duration? retryAfter;

  const AIServiceException(
    this.message, {
    this.isQuotaExceeded = false,
    this.retryAfter,
  });

  @override
  String toString() => message;
}

class SimpleAIService {
  static const String _defaultErrorMessage =
      'عذراً، حدث خطأ تقني. يرجى المحاولة مرة أخرى لاحقاً.';

  String _apiKey = '';
  GenerativeModel? _model;
  ChatSession? _chatSession;

  SimpleAIService() {
    updateApiKey(ApiConfig.geminiApiKey);
  }

  /// تحديث المفتاح وتهيئة الموديل والجلسة
  void updateApiKey(String apiKey) {
    _apiKey = apiKey.trim();

    // استخدم موديل حديث. جرّب pro لو عايز reasoning أطول.
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', // أو: 'gemini-2.5-pro'
      apiKey: _apiKey,
      systemInstruction: Content.text(_buildSystemPrompt()),
      generationConfig: GenerationConfig(
        temperature: 0.3,
        topP: 0.8,
        maxOutputTokens: 1024,
      ),
      // ⚠️ تعمّدنا عدم تمرير safetySettings لتقليل الـfalse blocks.
      // لو عايز أقل قيود بشكل صريح (إن كان SDK يدعم):
      // safetySettings: const [
      //   SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
      //   SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
      //   SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
      //   SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      // ],
    );

    _chatSession = _model!.startChat(
      history: [
        Content.model([
          TextPart(
              'مرحباً! أنا برعي، مساعدك الذكي في متجر الأكواد المصدرية 💻 أنا هنا عشان أساعدك تختار أفضل الحلول التقنية لمشروعك! 🚀')
        ]),
      ],
    );
  }

  /// بدء جلسة جديدة
  void startNewChatSession() {
    if (_model != null) {
      _chatSession = _model!.startChat(
        history: [
          Content.model([TextPart('جلسة جديدة بدأت الآن.')])
        ],
      );
    }
  }

  /// رد غير متدفق
  Future<String> generateChatReply(String userText) async {
    if (_apiKey.isEmpty || _model == null) {
      throw const AIServiceException(_defaultErrorMessage);
    }
    _chatSession ??= _model!.startChat();

    // محاولة طبيعية + محاولة إنقاذ واحدة
    const Duration retryDelay = Duration(milliseconds: 500);

    // محاولة 1: كما هو
    final r1 = await _chatSession!.sendMessage(Content.text(userText));
    final txt1 = r1.text?.trim();
    final blocked1 = _isBlocked(r1);
    if (!blocked1 && txt1 != null && txt1.isNotEmpty)
      return _cleanMarkdown(txt1);

    // محاولة 2: إعادة صياغة آمنة
    final safePrompt = _safeRephrase(userText);
    await Future.delayed(retryDelay);
    final r2 = await _chatSession!.sendMessage(Content.text(safePrompt));
    final txt2 = r2.text?.trim();
    final blocked2 = _isBlocked(r2);
    if (!blocked2 && txt2 != null && txt2.isNotEmpty)
      return _cleanMarkdown(txt2);

    // لو لسه متمنع
    throw const AIServiceException(
      'تعذر توليد رد بسبب إعدادات السلامة. أعد صياغة سؤالك بصيغة تقنية ومحايدة.',
    );
  }

  /// رد متدفق (typing)
  Stream<String> streamChatReply(String userText) async* {
    if (_apiKey.isEmpty || _model == null) {
      throw const AIServiceException(_defaultErrorMessage);
    }
    _chatSession ??= _model!.startChat();

    final buffer = StringBuffer();
    await for (final chunk
        in _chatSession!.sendMessageStream(Content.text(userText))) {
      if (_isBlocked(chunk)) {
        throw const AIServiceException(
            'تم حجب الرد بسبب إعدادات السلامة. أعد صياغة سؤالك.');
      }

      final piece = chunk.text;
      if (piece != null && piece.isNotEmpty) {
        buffer.write(piece);
        yield buffer.toString();
      }
    }
  }

  /// يحدد إن كان الرد محجوبًا فعلاً
  bool _isBlocked(GenerateContentResponse resp) {
    final candidate = resp.candidates?.firstOrNull;
    final blockedByFeedback = resp.promptFeedback?.blockReason != null;
    // ✅ اعتبر بلوك فقط لما يكون finishReason == blocked
    // final blockedByFinishReason =
    // candidate?.finishReason == FinishReason.blocked;
    return blockedByFeedback;
  }

  String _buildSystemPrompt() {
    return '''
أنت برعي، المساعد الذكي كود شوب 💻

## هويتك:
- اسمك: برعي
- شخصيتك: ودود، مساعد، خبير تقني، متحمس للتكنولوجيا
- أسلوبك: عربي بسيط وواضح، مع استخدام الإيموجي المناسب

## معلومات عن متجر الأكواد المصدرية:
نحن متجر متخصص في الحلول التقنية الجاهزة والمخصصة:

### 🌐 المواقع الجاهزة:
- مواقع تجارة إلكترونية
- مواقع شركات ومؤسسات  
- مواقع شخصية ومدونات
- مواقع خدمات ومطاعم
- جميع المواقع جاهزة للاستخدام فوراً

### 📱 التطبيقات:
- تطبيقات أندرويد وآيفون
- تطبيقات ويب تفاعلية
- تطبيقات إدارية للشركات

### ⚙️ الأنظمة الإدارية:
- أنظمة إدارة المخازن
- أنظمة المحاسبة والفواتير
- أنظمة إدارة الموظفين
- أنظمة نقاط البيع (POS)

### 🚚 خدمة التوصيل والتركيب:
- نوصل لحد شركتك أو مكتبك
- نركب النظام ونشغله لك
- ندربك على الاستخدام
- متوفر الدفع عند التوصيل

### 🛠️ خدمة الصيانة والتعديلات:
- صيانة دورية مجانية
- تعديلات وتحديثات حسب احتياجاتك
- دعم فني مستمر

### 🎯 التطوير المخصص:
- تطوير مواقع من الصفر حسب طلبك
- تطوير تطبيقات مخصصة
- تطوير أنظمة خاصة بشركتك

## دورك كمساعد:
1. ساعد العملاء في اختيار الحل المناسب
2. اقترح حلول للعملاء المترددين أو المشتتين
3. وضح مميزات كل خدمة
4. أجب على الأسئلة التقنية
5. وجه العملاء للتواصل معنا للطلب

## أسلوب الرد:
- استخدم العربية البسيطة المصرية
- كن ودود ومتحمس
- اقترح الحلول المناسبة
- ممنوع نهائياً ذكر أي أسعار أو أرقام مالية (مثل 1 \$ أو 100 جنيه أو أي عملة)
- اختصر في الردود لكن كن مفيد
- لا تستخدم أي رموز markdown مثل ** أو __ أو #  في النص
- اكتب النص بشكل عادي بدون تنسيق markdown
- لا تذكر أي أرقام تخص المال أو التكلفة أو الأسعار

مثال على رد جيد:
"أهلاً وسهلاً! 😊 بناءً على احتياجاتك، أنصحك بموقع التجارة الإلكترونية الجاهز 🛒 - سهل الاستخدام ومتكامل مع وسائل الدفع. ممكن نوصله لك ونركبه في شركتك خلال يومين! عايز تعرف تفاصيل أكتر؟"
''';
  }

  String _safeRephrase(String raw) {
    return '''
أعد صياغة الطلب التالي إلى سؤال تقني محايد وخالٍ من أي محتوى حساس، ثم أجب إجابة تقنية قصيرة وواضحة:
$raw
''';
  }

  /// تنظيف النص من رموز markdown والأرقام المالية
  String _cleanMarkdown(String text) {
    return text
        .replaceAll(RegExp(r'\*\*(.*?)\*\*'), r'') // إزالة **نص**
        .replaceAll(RegExp(r'\*(.*?)\*'), r'') // إزالة *نص*
        .replaceAll(RegExp(r'__(.*?)__'), r'') // إزالة __نص__
        .replaceAll(RegExp(r'_(.*?)_'), r'') // إزالة _نص_
        .replaceAll(RegExp(r'#{1,6}\s*'), '') // إزالة # للعناوين
        .replaceAll(RegExp(r'`(.*?)`'), r'') // إزالة `كود`
        .replaceAll(RegExp(r'```.*?```', dotAll: true), '') // إزالة كتل الكود
        .replaceAll(
            RegExp(r'\d+\s*\$'), '') // إزالة أرقام بالدولار مثل 1$ أو 100$
        .replaceAll(RegExp(r'\d+\s*(جنيه|ريال|درهم|دينار)'),
            '') // إزالة أرقام بالعملات العربية
        .replaceAll(RegExp(r'\$\s*\d+'), '') // إزالة $1 أو $100
        .trim();
  }

  void dispose() {
    _chatSession = null;
    _model = null;
  }
}

/// إضافة مساعدة للحصول على أول عنصر بأمان
extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
