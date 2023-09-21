import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/model/mynote.dart';
import 'package:noteapp/services/db.dart';
import 'package:noteapp/services/firebase_service.dart';

FireDB firestore = FireDB();

class newNote extends StatefulWidget {
  const newNote({super.key});

  @override
  State<newNote> createState() => _newNoteState();
}

class _newNoteState extends State<newNote> {
  TextEditingController contrlTitle = new TextEditingController();
  TextEditingController contrlContent = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contrlContent.dispose();
    contrlTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.3,
        actions: [
          IconButton(
            onPressed: () async {
              note? noteEx = await noteDatabase.instance.InsertEntry(note(
                  pin: false,
                  isArchived: false,
                  title: contrlTitle.text,
                  content: contrlContent.text,
                  createdTime: DateTime.now()));

              await firestore.createNoteFirestore(
                  FirebaseAuth.instance.currentUser!.email,
                  noteEx!.id.toString(),
                  contrlTitle.text,
                  contrlContent.text,
                  noteEx.isArchived,
                  noteEx.pin);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save_outlined),
            splashRadius: 17,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                controller: contrlTitle,
                cursorColor: white,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: TextField(
                controller: contrlContent,
                keyboardType: TextInputType.multiline,
                minLines: 50,
                maxLines: null,
                cursorColor: white,
                style: const TextStyle(fontSize: 25, color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
