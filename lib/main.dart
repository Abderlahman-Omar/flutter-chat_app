// import 'package:chat_app/firebase_options.dart';
// import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const ChatApp());
// }

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeView.id: (context) {
          return HomeView();
        },
        RegisterView.id: (context) {
          return RegisterView();
        },
        ChatView.id: (context) {
          return ChatView();
        }
      },
      initialRoute: HomeView.id,
    );
  }
}
