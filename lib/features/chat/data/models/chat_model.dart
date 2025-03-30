import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.content,
    required super.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
