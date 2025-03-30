import 'package:chat_app/features/conversations/domain/entities/conversation_entity.dart';
import 'package:chat_app/features/conversations/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;

  FetchConversationsUseCase(this.repository);

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversations();
  }
}
