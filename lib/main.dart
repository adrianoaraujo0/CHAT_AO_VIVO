import 'package:aplicativo_chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

  // FirebaseFirestore.instance
  //     .collection("Mensagens")
  //     .doc("msg1")
  //     .snapshots()
  //     .listen((event) {
  //   print(event.data());
  // });

  // FirebaseFirestore.instance.collection("Mensagens").snapshots().listen((d) {
  //   d.docs.forEach((element) {
  //     print(element.data());
  //   });
  // });

  // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //     .collection("Mensagens")
  //     .doc("msg1")
  //     .get();

  // print(documentSnapshot.data());

  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection("Mensagens").get();
  // snapshot.docs.forEach((element) {
  //   element.reference.update({"read": false});
  //   print(element.data());
  //   print(element.id);
  // });

  // FirebaseFirestore.instance
  //     .collection("Mensagens")
  //     .doc("NkJGKH9CdQTzyvyIMS4D")
  //     .collection("arquivos")
  //     .doc()
  //     .set({
  //   "image": "foto_perfil.png",
  // });

  // Firebase.initializeApp().then((_) {
  //   FirebaseFirestore.instance.collection("test").get().then((value) {
  //     print('\n\nvalue ${value.docChanges}\n\n');
  //   });
  // });

  // QuerySnapshot vários documentos de uma coleçao
  // DocumentSnapshot um documento de uma coleçao
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.blue)),
      home: ChatScreen(),
    );
  }
}
