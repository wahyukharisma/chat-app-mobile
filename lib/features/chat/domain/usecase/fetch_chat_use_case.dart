import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class FetchChatUseCase {
  final ChatRepository chatRepository;

  FetchChatUseCase({required this.chatRepository});

  Future<List<ChatEntity>> call(String conversationId) async {
    return await chatRepository.fetchChats(conversationId);
  }
}
