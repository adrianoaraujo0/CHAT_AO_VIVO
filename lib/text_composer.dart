import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({super.key});

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool isComposing = false;

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
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (value) {
                setState(() {
                  value.isNotEmpty;
                });
              },
              onSubmitted: (value) {},
            ),
          ),
          IconButton(
            onPressed: isComposing ? () {} : null,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
