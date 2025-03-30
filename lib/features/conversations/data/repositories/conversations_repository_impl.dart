import 'package:chat_app/features/conversations/data/datasources/conversations_remote_data_source.dart';
import 'package:chat_app/features/conversations/domain/entities/conversation_entity.dart';
import 'package:chat_app/features/conversations/domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl extends ConversationsRepository {
  final ConversationsRemoteDataSource conversationsRemoteDataSource;

  ConversationsRepositoryImpl({required this.conversationsRemoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await conversationsRemoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) async {
    return await conversationsRemoteDataSource.checkOrCreateConversation(
      contactId: contactId,
    );
  }
}
