import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';
import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUseCase {
  final ContactsRepository contactRepository;

  FetchContactsUseCase({required this.contactRepository});

  Future<List<ContactsEntitiy>> call() async {
    return await contactRepository.fetchContacts();
  }
}
