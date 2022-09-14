import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  final Function({String text, XFile? imgFile}) sendMessage;

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
            onPressed: () async {
              print("entrouuuuuuuuuuuuuuuuuu");
              final XFile? imgfile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              print("tirou a foto");
              if (imgfile == null) return;
              widget.sendMessage(imgFile: imgfile);
              print(imgfile.path.toString());
            },
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
                widget.sendMessage(text: text);
                reset();
              },
            ),
          ),
          IconButton(
            onPressed: isComposing
                ? null
                : () {
                    widget.sendMessage(text: controller.text);
                    reset();
                  },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
