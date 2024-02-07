import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_page.dart';
import 'package:projetos_flutter_dio/src/shared/custom_text_form_field.dart';

class LoginChatPage extends StatefulWidget {
  final String title;
  const LoginChatPage({super.key, required this.title});

  @override
  State<LoginChatPage> createState() => _LoginChatPageState();
}

class _LoginChatPageState extends State<LoginChatPage> {
  final usernameEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: CustomTextField(
                  controller: usernameEC,
                  label: 'Como quer ser chamado?',
                  inputBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        title: 'Chat',
                        username: usernameEC.text.trim(),
                      ),
                    ),
                  );
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
