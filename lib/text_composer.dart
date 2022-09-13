import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({super.key});

  @override
  State<TextComposer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TextComposer> {
  bool isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo_camera),
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
