import 'package:equatable/equatable.dart';

enum MessageType { text }

enum MessageSender { user, ai }

class ChatMessage extends Equatable {
  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final MessageType type;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.type = MessageType.text,
  });

  factory ChatMessage.userText(String content) {
    final now = DateTime.now();
    return ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      content: content,
      sender: MessageSender.user,
      timestamp: now,
      type: MessageType.text,
    );
  }

  factory ChatMessage.aiReply(String content) {
    final now = DateTime.now();
    return ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      content: content,
      sender: MessageSender.ai,
      timestamp: now,
      type: MessageType.text,
    );
  }

  ChatMessage copyWith({
    String? id,
    String? content,
    MessageSender? sender,
    DateTime? timestamp,
    MessageType? type,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'sender': sender.name,
        'timestamp': timestamp.toIso8601String(),
        'type': type.name,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: MessageSender.values.firstWhere(
        (e) => e.name == (json['sender'] as String),
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: MessageType.values.firstWhere(
        (e) => e.name == (json['type'] as String),
      ),
    );
  }

  @override
  List<Object?> get props => [id, content, sender, timestamp, type];
}

class SimpleChat extends Equatable {
  final String id;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final bool isCompleted;

  const SimpleChat({
    required this.id,
    required this.messages,
    required this.createdAt,
    this.isCompleted = false,
  });

  factory SimpleChat.newChat() {
    final chatId = DateTime.now().microsecondsSinceEpoch.toString();
    return SimpleChat(
      id: chatId,
      messages: [
        ChatMessage.aiReply(
          'مرحباً! أنا برعي 👋\n\nمساعدك الذكي في كود شوب 💻\n\nأنا هنا عشان أساعدك تختار أفضل الحلول التقنية:\n\n🌐 مواقع ويب جاهزة\n📱 تطبيقات موبايل\n⚙️ أنظمة إدارية\n🛠️ تطوير مخصص من الصفر\n\nإيه اللي محتاجه النهارده؟',
        ),
      ],
      createdAt: DateTime.now(),
    );
  }

  SimpleChat addMessage(ChatMessage message) {
    // مهم: ارجع قائمة “جديدة” عشان الـUI يعمل rebuild
    final updated = List<ChatMessage>.from(messages)..add(message);
    return copyWith(messages: updated);
  }

  SimpleChat addMessages(List<ChatMessage> newMessages) {
    final updated = List<ChatMessage>.from(messages)..addAll(newMessages);
    return copyWith(messages: updated);
  }

  SimpleChat complete() => copyWith(isCompleted: true);

  SimpleChat copyWith({
    String? id,
    List<ChatMessage>? messages,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return SimpleChat(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'messages': messages.map((m) => m.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'isCompleted': isCompleted,
      };

  factory SimpleChat.fromJson(Map<String, dynamic> json) {
    final rawList = (json['messages'] as List);
    final parsed = rawList
        .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
        .toList();
    return SimpleChat(
      id: json['id'] as String,
      messages: parsed,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: (json['isCompleted'] as bool?) ?? false,
    );
  }

  @override
  List<Object?> get props => [id, messages, createdAt, isCompleted];
}
