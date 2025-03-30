import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/entities/daily_question_entity.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> fetchChats(String conversationId);
  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId);
  Future<void> sendChat(ChatEntity chat);
}
