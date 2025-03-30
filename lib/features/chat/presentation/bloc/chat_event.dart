abstract class ChatEvent {}

class LoadChatEvent extends ChatEvent {
  final String conversationId;
  LoadChatEvent(this.conversationId);
}

class SendChatEvent extends ChatEvent {
  final String conversationId;
  final String content;

  SendChatEvent(this.conversationId, this.content);
}

class ReceivedChatEvent extends ChatEvent {
  final Map<String, dynamic> chat;

  ReceivedChatEvent(this.chat);
}

class LoadDailyQuestionEvent extends ChatEvent {
  final String conversationId;

  LoadDailyQuestionEvent({required this.conversationId});
}
