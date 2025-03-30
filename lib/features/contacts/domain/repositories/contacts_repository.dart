import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';

abstract class ContactsRepository {
  Future<List<ContactsEntitiy>> fetchContacts();
  Future<void> addContact({required String email});
}
