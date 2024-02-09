import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  final FocusNode focus;
  final TextEditingController controller;
  final void Function(String)? onSubmited;
  final void Function() onPressed;

  const ChatTextField({
    super.key,
    required this.focus,
    required this.controller,
    required this.onSubmited,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
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
        maxWidth: screenWidth > 1000 ? screenWidth / 3 : screenWidth * .8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              focusNode: focus,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: onSubmited,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
