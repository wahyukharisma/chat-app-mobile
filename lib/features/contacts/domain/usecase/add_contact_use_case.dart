import '../repositories/contacts_repository.dart';

class AddContactUseCase {
  final ContactsRepository contactRepository;

  AddContactUseCase({required this.contactRepository});

  Future<void> call({required String email}) async {
    return await contactRepository.addContact(email: email);
  }
}
