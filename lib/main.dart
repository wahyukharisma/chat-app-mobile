import 'package:chat_app/core/socket_service.dart';
import 'package:chat_app/di_container.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/core/theme.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chat_app/features/conversations/presentation/bloc/conversations_bloc.dart';
import 'package:chat_app/features/conversations/presentation/page/conversations_page.dart';
import 'package:chat_app/features/auth/presentation/pages/login_page.dart';
import 'package:chat_app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final socketServices = SocketService();
  await socketServices.initSocket();

  // setting up getId
  setupDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(registerUseCase: sl(), loginUseCase: sl()),
        ),
        BlocProvider(create: (_) => ConversationsBloc(sl())),
        BlocProvider(
          create:
              (_) => ChatBloc(
                fetchChatUseCase: sl(),
                fetchDailyQuestionUserCase: sl(),
              ),
        ),
        BlocProvider(
          create:
              (_) => ContactsBloc(
                fetchContactsUseCase: sl(),
                addContactUseCase: sl(),
                checkOrCreateConversationUseCase: sl(),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login-page': (_) => LoginPage(),
          '/register-page': (_) => RegisterPage(),
          '/conversations-page': (_) => ConversationsPage(),
        },
      ),
    );
  }
}
