import 'dart:convert';

import 'package:chat_app/features/chat/data/models/chat_model.dart';
import 'package:chat_app/features/chat/data/models/daily_question_model.dart';
import 'package:chat_app/features/chat/domain/entities/chat_entity.dart';
import 'package:chat_app/features/chat/domain/entities/daily_question_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatRemoteDataSource {
  final String baseUrl;

  ChatRemoteDataSource({required this.baseUrl});

  final _storage = FlutterSecureStorage();

  Future<List<ChatEntity>> fetchChats(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/messages/$conversationId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Chat');
    }
  }

  Future<DailyQuestionModel> fetchDailyQuestion(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/conversations/$conversationId/daily-question'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return DailyQuestionModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch daily question');
    }
  }
}
