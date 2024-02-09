import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/rooms_page.dart';
import 'package:projetos_flutter_dio/src/shared/custom_text_form_field.dart';

class ChatLoginPage extends StatefulWidget {
  final String title;
  const ChatLoginPage({super.key, required this.title});

  @override
  State<ChatLoginPage> createState() => _ChatLoginPageState();
}

class _ChatLoginPageState extends State<ChatLoginPage> {
  final usernameEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        elevation: 0,
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
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: () {
                  if (usernameEC.text.trim().isEmpty) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomsPage(
                        title: 'Salas de chat',
                        username: usernameEC.text.trim(),
                      ),

                      // ChatPage(
                      //   title: 'Chat',
                      //   username: usernameEC.text.trim(),
                      // ),
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
