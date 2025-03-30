import 'dart:convert';

import 'package:chat_app/features/contacts/data/models/contact_models.dart';
import 'package:chat_app/features/contacts/domain/entities/contacts_entitiy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContactRemoteDataSource {
  final String baseUrl;

  ContactRemoteDataSource({required this.baseUrl});

  final _storage = FlutterSecureStorage();

  Future<List<ContactModels>> fetchContacts() async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/contacts'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ContactModels.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Chat');
    }
  }

  Future<void> addContact({required String email}) async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      body: jsonEncode({'contactEmail': email}),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }
}
