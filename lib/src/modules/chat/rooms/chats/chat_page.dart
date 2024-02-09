import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/chats/chat_controller.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/widgets/chat_message.dart';
import 'package:projetos_flutter_dio/src/modules/chat/rooms/widgets/chat_text_field.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_button.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String username;
  final String room;
  const ChatPage({
    super.key,
    required this.title,
    required this.username,
    required this.room,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatController = di<ChatController>();
  final focus = FocusNode();
  final messageEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatController.init();
    focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: const [
          DarkModeButton(),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: _chatController.listen(widget.room),
                      builder: (context, snapshot) {
                        if (snapshot.inState(ConnectionState.done).hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _chatController.chatScrollCt.jumpTo(_chatController
                                .chatScrollCt.position.maxScrollExtent);
                          });
                        }
                        return !snapshot.hasData
                            ? const Center(child: CircularProgressIndicator())
                            : ListView(
                                controller: _chatController.chatScrollCt,
                                children: snapshot.data!.docs.map(
                                  (e) {
                                    var messageModel = MessageModel.fromJson(
                                        (e.data() as Map<String, dynamic>));
                                    return ChatMessage(
                                      isUserMessage:
                                          _chatController.isUserMessage(
                                        messageModel.userId,
                                      ),
                                      messageModel: messageModel,
                                    );
                                  },
                                ).toList(),
                              );
                      })),
              ChatTextField(
                focus: focus,
                controller: messageEC,
                onSubmited: (_) {
                  _chatController.sendMessage(
                    messageEC,
                    widget.username,
                    widget.room,
                  );
                  focus.requestFocus();
                },
                onPressed: () => _chatController.sendMessage(
                  messageEC,
                  widget.username,
                  widget.room,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
