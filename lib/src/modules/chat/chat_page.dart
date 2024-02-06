import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_repository.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({super.key, required this.title});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatRepository = di<ChatRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _chatRepository.create();
          },
          child: const Text('Teste'),
        ),
      ),
    );
  }
}
