import 'package:chat_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/usecase/login_use_case.dart';
import 'package:chat_app/features/auth/domain/usecase/register_use_case.dart';
import 'package:chat_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/features/chat/domain/usecase/fetch_chat_use_case.dart';
import 'package:chat_app/features/chat/domain/usecase/fetch_daily_question_user_case.dart';
import 'package:chat_app/features/contacts/data/datasource/contact_remote_data_source.dart';
import 'package:chat_app/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:chat_app/features/contacts/domain/usecase/add_contact_use_case.dart';
import 'package:chat_app/features/contacts/domain/usecase/fetch_contacts_use_case.dart';
import 'package:chat_app/features/conversations/data/datasources/conversations_remote_data_source.dart';
import 'package:chat_app/features/conversations/data/repositories/conversations_repository_impl.dart';
import 'package:chat_app/features/conversations/domain/usecase/check_or_create_conversation_use_case.dart';
import 'package:chat_app/features/conversations/domain/usecase/fetch_conversations_use_case.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/contacts/domain/repositories/contacts_repository.dart';
import 'features/conversations/domain/repositories/conversations_repository.dart';

final GetIt sl = GetIt.asNewInstance();

void setupDependencies() {
  const String baseUrl = 'http://192.168.18.83:6000';

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(baseUrl: baseUrl),
  );

  sl.registerLazySingleton<ConversationsRemoteDataSource>(
    () => ConversationsRemoteDataSource(baseUrl: baseUrl),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSource(baseUrl: baseUrl),
  );

  sl.registerLazySingleton<ContactRemoteDataSource>(
    () => ContactRemoteDataSource(baseUrl: baseUrl),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<ConversationsRepository>(
    () => ConversationsRepositoryImpl(conversationsRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(chatRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<ContactsRepository>(
    () => ContactRepositoryImpl(contactRemoteDataSource: sl()),
  );

  // Use case
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchConversationsUseCase(sl()));
  sl.registerLazySingleton(() => FetchChatUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => FetchContactsUseCase(contactRepository: sl()));
  sl.registerLazySingleton(() => AddContactUseCase(contactRepository: sl()));
  sl.registerLazySingleton(
    () => CheckOrCreateConversationUseCase(conversationsRepository: sl()),
  );
  sl.registerLazySingleton(
    () => FetchDailyQuestionUserCase(chatRepository: sl()),
  );
}
