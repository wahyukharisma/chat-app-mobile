class ChatEntity {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime createdAt;

  ChatEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });
}
