import 'package:chat_app/features/contacts/data/datasource/contact_remote_data_source.dart';
import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';
import 'package:chat_app/features/contacts/domain/repositories/contacts_repository.dart';

class ContactRepositoryImpl extends ContactsRepository {
  final ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});

  @override
  Future<void> addContact({required String email}) async {
    await contactRemoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactsEntitiy>> fetchContacts() async {
    return await contactRemoteDataSource.fetchContacts();
  }
}
