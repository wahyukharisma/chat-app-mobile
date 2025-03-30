import 'package:chat_app/features/chat/domain/entities/daily_question_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class FetchDailyQuestionUserCase {
  final ChatRepository chatRepository;

  FetchDailyQuestionUserCase({required this.chatRepository});

  Future<DailyQuestionEntity> call(String conversationId) async {
    return await chatRepository.fetchDailyQuestion(conversationId);
  }
}
