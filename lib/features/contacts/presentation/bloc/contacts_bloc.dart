import 'package:chat_app/features/contacts/domain/usecase/add_contact_use_case.dart';
import 'package:chat_app/features/contacts/domain/usecase/fetch_contacts_use_case.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../conversations/domain/usecase/check_or_create_conversation_use_case.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  ContactsBloc({
    required this.fetchContactsUseCase,
    required this.addContactUseCase,
    required this.checkOrCreateConversationUseCase,
  }) : super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
    on<CheckOrCreateConversation>(_onCheckOrCreateConversation);
  }

  Future<void> _onFetchContacts(
    FetchContacts event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactLoading());

    try {
      final contacts = await fetchContactsUseCase();
      emit(ContactsLoaded(contacts: contacts));
    } catch (err) {
      emit(ContactsError(message: 'Failed to fetch contacts'));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactLoading());

    try {
      await addContactUseCase(email: event.email);
      emit(ContastAdded());
      add(FetchContacts());
    } catch (err) {
      emit(ContastAddedFailed(message: 'Failed to add contacts'));
    }
  }

  Future<void> _onCheckOrCreateConversation(
    CheckOrCreateConversation event,
    Emitter<ContactsState> emit,
  ) async {
    try {
      final conversationId = await checkOrCreateConversationUseCase(
        contactId: event.contactId,
      );
      emit(
        ConversationReady(
          conversationId: conversationId,
          contactName: event.contactName,
        ),
      );
    } catch (err) {
      emit(ContactsError(message: 'Failed to start conversation'));
    }
  }
}
