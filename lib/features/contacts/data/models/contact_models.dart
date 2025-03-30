import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';

class ContactModels extends ContactsEntitiy {
  ContactModels({
    required super.id,
    required super.username,
    required super.email,
  });

  factory ContactModels.fromJson(Map<String, dynamic> json) {
    return ContactModels(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
