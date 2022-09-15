import 'dart:collection';
import 'dart:io';

import 'package:aplicativo_chat/chat_message.dart';
import 'package:aplicativo_chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late User? currentUser;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUser = user;
    });
  }

  Future<User?> getUser() async {
    if (currentUser != null) return currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  void sendMessage({String? text, XFile? imgFile}) async {
    final User? user = await getUser();
    if (user == null) {
      scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Nao foi possível fazer o login. Tente novamente."),
        ),
      );
    }
    Map<String, dynamic> data = {
      "uid": user?.uid,
      "senderName": user?.displayName,
      "senderPhotoUrl": user?.photoURL,
    };

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
      key: scaffoldKey,
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
                    List<DocumentSnapshot<Map<String, dynamic>>> documents =
                        snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic>? data = documents[index].data();
                        print(
                            "-----------------------------------------------");
                        if (data == null) {
                          print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                        }
                        // print("${data.runtimeType}");
                        print(
                            "-----------------------------------------------");

                        return ChatMessage(data, true);
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
