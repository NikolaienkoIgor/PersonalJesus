import 'package:chatgpt_client/api/chat_api.dart';
import 'package:chatgpt_client/models/chat_message.dart';
import 'package:chatgpt_client/widgets/message_bubble.dart';
import 'package:chatgpt_client/widgets/message_composer.dart';
import 'package:flutter/material.dart';

// Клас ChatPage який наслідує стан StatefulWidget
class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.chatApi,
    super.key,
  });

  final ChatApi chatApi;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Клас _ChatPageState який містить віджет сторінки чату
class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[
    ChatMessage('Hello, how can I help?', false),
  ];
  var _awaitingResponse = false;
  var isTrigger = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: true, // відобразити повідомлення в зворотньому порядку
                children: [
                  ..._messages.reversed.map(
                        (msg) => MessageBubble(
                      content: msg.content,
                      isUserMessage: msg.isUserMessage,
                    ),
                  ),
                ],
              ),
            ),
            MessageComposer(
              onSubmitted: _onSubmitted,
              awaitingResponse: _awaitingResponse,
            ),
          ],
        ),
      ),
    );
  }

  // Функція, яка оброблює подані користувачем повідомлення
  Future<void> _onSubmitted(String message) async {
    if(isTrigger){
      setState(() {
        _messages.add(ChatMessage(message, true));
        _awaitingResponse = false;
      });
      isTrigger = false;
    }else {
      setState(() {
        _messages.add(ChatMessage(message, true));
        _awaitingResponse = true;
      });
    }
    try {
      final response = await widget.chatApi.completeChat(_messages);
      setState(() {
        _messages.add(ChatMessage(response, false));
        _awaitingResponse = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}