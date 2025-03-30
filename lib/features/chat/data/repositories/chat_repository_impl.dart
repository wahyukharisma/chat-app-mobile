import 'package:chat_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

import '../../domain/entities/daily_question_entity.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Future<List<ChatEntity>> fetchChats(String conversationId) async {
    return await chatRemoteDataSource.fetchChats(conversationId);
  }

  @override
  Future<void> sendChat(ChatEntity chat) {
    throw UnimplementedError();
  }

  @override
  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId) async {
    return await chatRemoteDataSource.fetchDailyQuestion(conversationId);
  }
}
