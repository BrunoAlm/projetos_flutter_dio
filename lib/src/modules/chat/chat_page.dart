import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/core/shared_preferences_config.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_controller.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/widgets/chat_message.dart';
import 'package:projetos_flutter_dio/src/shared/dark_mode_service.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String username;
  const ChatPage({super.key, required this.title, required this.username});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatController = di<ChatController>();
  final _sharedPrefs = di<SharedPreferencesConfig>();

  final messageEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    _sharedPrefs.getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  _sendMessage() async {
    if (messageEC.text.trim().isEmpty) return;
    var chat = ChatMessageModel(
      message: messageEC.text.trim(),
      userId: _sharedPrefs.userId,
      username: widget.username,
    );
    await _chatController.createChat(chat);
    messageEC.clear();
    _chatController.chatScrollCt
        .jumpTo(_chatController.chatScrollCt.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Consumer<DarkModeService>(
              builder: (context, darkModeService, child) => IconButton(
                onPressed: () =>
                    darkModeService.darkMode = !darkModeService.darkMode,
                icon: Icon(
                  darkModeService.darkMode ? Icons.dark_mode : Icons.light_mode,
                ),
              ),
            ),
          ),
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
                stream: _chatController.listen(),
                builder: (context, snapshot) {
                  if (snapshot.inState(ConnectionState.done).hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _chatController.chatScrollCt.jumpTo(_chatController
                          .chatScrollCt.position.maxScrollExtent);
                    });
                  }
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView(
                          controller: _chatController.chatScrollCt,
                          children: snapshot.data!.docs.map((e) {
                            var messageModel = ChatMessageModel.fromJson(
                              (e.data() as Map<String, dynamic>),
                            );
                            return ChatMessage(
                              isUserMessage:
                                  _sharedPrefs.userId == messageModel.userId,
                              messageModel: messageModel,
                            );
                          }).toList());
                },
              )),
              Container(
                decoration: ShapeDecoration(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 28, right: 8),
                constraints: BoxConstraints(
                  maxWidth:
                      screenWidth > 1000 ? screenWidth / 3 : screenWidth * .8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: messageEC,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _sendMessage(),
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
