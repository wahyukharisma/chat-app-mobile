import 'package:chat_app/features/conversations/domain/entities/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<List<ConversationEntity>> fetchConversations();
  Future<String> checkOrCreateConversation({required String contactId});
}
