import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/usecase/fetch_chat_use_case.dart';
import 'package:chat_app/features/chat/domain/usecase/fetch_daily_question_user_case.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchChatUseCase fetchChatUseCase;
  final FetchDailyQuestionUserCase fetchDailyQuestionUserCase;
  final SocketService _socketService = SocketService();
  final List<ChatEntity> _chats = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({
    required this.fetchDailyQuestionUserCase,
    required this.fetchChatUseCase,
  }) : super(ChatLoadingState()) {
    on<LoadChatEvent>(_onLoadChat);
    on<ReceivedChatEvent>(_onReceivedChat);
    on<SendChatEvent>(_onSendChat);
    on<LoadDailyQuestionEvent>(_onLoadDailyQuestionEvent);
  }

  Future<void> _onLoadChat(LoadChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      final chat = await fetchChatUseCase(event.conversationId);
      _chats.clear();
      _chats.addAll(chat);
      emit(ChatLoadedState(List.from(_chats)));

      _socketService.socket.emit('joinConversation', event.conversationId);

      _socketService.socket.off('newMessage');

      _socketService.socket.on('newMessage', (data) {
        add(ReceivedChatEvent(data));
      });
    } catch (err) {
      emit(ChatErrorState('Failed to load chat'));
    }
  }

  Future<void> _onReceivedChat(
    ReceivedChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    final chat = ChatEntity(
      id: event.chat['id'],
      conversationId: event.chat['conversation_id'],
      senderId: event.chat['sender_id'],
      content: event.chat['content'],
      createdAt: DateTime.parse(event.chat['created_at']),
    );

    _chats.add(chat);
    emit(ChatLoadedState(List.from(_chats)));
  }

  Future<void> _onSendChat(SendChatEvent event, Emitter<ChatState> emit) async {
    String userId = await _storage.read(key: 'userId') ?? '';

    final newMessage = {
      'conversationId': event.conversationId,
      'senderId': userId,
      'content': event.content,
    };

    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onLoadDailyQuestionEvent(
    LoadDailyQuestionEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoadingState());
      final dailyQuestion = await fetchDailyQuestionUserCase(
        event.conversationId,
      );
      emit(ChatDailyQuestionLoadedState(question: dailyQuestion));
    } catch (error) {
      emit(ChatErrorState('Failed to load Daily question'));
    }
  }
}
