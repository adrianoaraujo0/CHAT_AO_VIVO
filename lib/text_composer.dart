import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  Function(String) sendMessage;

  TextComposer(this.sendMessage);

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool isComposing = false;
  final TextEditingController controller = TextEditingController();

  void reset() {
    controller.clear();
    setState(() {
      isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (value) {
                setState(() {
                  value.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text);
                reset();
              },
            ),
          ),
          IconButton(
            onPressed: isComposing
                ? null
                : () {
                    widget.sendMessage(controller.text);
                    reset();
                  },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
