import 'dart:developer';

import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/features/conversations/domain/usecase/fetch_conversations_use_case.dart';
import 'package:chat_app/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:chat_app/features/conversations/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();

  ConversationsBloc(this.fetchConversationsUseCase)
    : super(ConversationsInitial()) {
    on<FetchConversationsEvent>(_onFetchConversations);

    _initializeSocketListener();
  }

  void _initializeSocketListener() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
    } catch (e) {
      log("Error intializing socket listener : $e");
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversationsEvent());
  }

  Future<void> _onFetchConversations(
    FetchConversationsEvent event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(ConversationsLoading());

    try {
      final conversations = await fetchConversationsUseCase();
      emit(ConversationsLoaded(conversations));
    } catch (error) {
      emit(ConversationsError('Failed to load conversations'));
    }
  }
}
