import 'dart:io';

import 'package:aplicativo_chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void sendMessage({String? text, XFile? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      //uploadtask: Uma classe que indica uma tarefa de upload em andamento.
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(File(imgFile.path));

      //Um [TaskSnapshot] é retornado como resultado ou processo em andamento de um [Task].
      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();
      print("url = $url");

      data["imgUrl"] = url;
    }

    if (text != null) data["texto"] = text;

    FirebaseFirestore.instance.collection("messages").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olá")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("messages").snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(documents[index].data().toString()));
                      },
                    );
                }
              },
            ),
          ),
          TextComposer(sendMessage),
        ],
      ),
    );
  }
}
