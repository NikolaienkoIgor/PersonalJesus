import 'package:chatgpt_client/api/chat_api.dart';
import 'package:chatgpt_client/chat_page.dart';
import 'package:flutter/material.dart';

// void means that there is no return variable
// main is an entry point of the program
// runApp is root widget to start the app
// ChatApp(chatApi: ChatApi()) creates an instance of the ChatApp widget and
// passes chatApi parameter as a ChatApi instance 
// like runApp(MyApp(greeting: 'Hello, World!'))
void main() {
  runApp(ChatApp(chatApi: ChatApi()));
}
// ChatApp is a subclass of StatelessWidget Superclass
class ChatApp extends StatelessWidget {
  // here chatApi is a fix instance variable of type 'ChatApi' in ChatApp class 
  // The ChatApi type is a custom class
  // chatApi variable will be passed to ChatPage Widget
  final ChatApi chatApi;
  // 'const' indicates an immutable instance of the class (nice to have)
  // 'ChatApp()' is a constructor of ChatApp class
  // 'required' indicates that this.chatApi cannot be null
  // super.key is used to pass the key parameter to the superclass constructor.
  const ChatApp({required this.chatApi, super.key});

  // @override indicates that ChatApp is overriding 
  // the build method of its superclass, StatelessWidget
  @override
  // build is a method of ChatApp returns a MaterialApp widget, 
  // which is a type of widget that provides a basic structure for a Material Design app.
  // build is defined as an abstract method that it must be implemented by any class 
  // that extends StatelessWidget.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Client',
      theme: ThemeData(
        // Зміна колярів по RGB
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(214, 242, 244, 1),
          secondary: Color.fromRGBO(236, 231, 231, 1),
        ),
      ),
      home: ChatPage(chatApi: chatApi),
    );
  }
}
