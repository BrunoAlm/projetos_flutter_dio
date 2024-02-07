import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_message_model.dart';

class ChatMessage extends StatelessWidget {
  final bool isUserMessage;
  final ChatMessageModel messageModel;
  const ChatMessage({
    super.key,
    required this.isUserMessage,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: ShapeDecoration(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          color: isUserMessage
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.inversePrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isUserMessage
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Text(
                      messageModel.username,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Text(
              messageModel.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
