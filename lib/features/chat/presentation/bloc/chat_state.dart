import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/entities/daily_question_entity.dart';

abstract class ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<ChatEntity> chats;

  ChatLoadedState(this.chats);
}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState(this.message);
}

class ChatDailyQuestionLoadedState extends ChatState {
  final DailyQuestionEntity question;

  ChatDailyQuestionLoadedState({required this.question});
}
