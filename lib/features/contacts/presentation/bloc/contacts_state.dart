import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactsEntitiy> contacts;

  ContactsLoaded({required this.contacts});
}

class ContactsError extends ContactsState {
  final String message;

  ContactsError({required this.message});
}

class ContastAdded extends ContactsState {}

class ContastAddedFailed extends ContactsState {
  final String message;

  ContastAddedFailed({required this.message});
}

class ConversationReady extends ContactsState {
  final String conversationId;
  final String contactName;

  ConversationReady({required this.conversationId, required this.contactName});
}
