import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/noteview.dart';

final user = FirebaseAuth.instance.currentUser;

class FireDB {
  // four method would be there create update read and delete

// creating node
  createNoteFirestore(gmail, id,title,content,archived,pinned) {
    FirebaseFirestore.instance
        .collection("notes")
        .doc(gmail)
        .collection("usernotes")
        .doc(id).set({
        "title": title,
        "content": content,
        "archived":archived,
        "pinned":pinned,
        "createdAt": DateTime.now()
      }).then((_) {
        print("Success");
      });

  }

  // recieving all notes
  getAllStoredNote(String gmail) async {
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(gmail)
        .collection("usernotes")
        .orderBy("createdAt")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        

        Map note = element.data();
        print(note["title"]);
      });
    });
  }

 // update all notes
  updateNoteFirestore(Title, content, gmail, id,archive,pinned) async {
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(gmail)
        .collection("usernotes")
        .doc(id)
        .update({
      "title": Title.toString(),
      "content": content.toString(),
      "archived" : archive ,
      "pinned" : pinned
    }).then((value) {
      print("data updated");
    });
  }

// deleted notes 
  deletedNoteFirestore(email, id) async {
    FirebaseFirestore.instance
        .collection("notes")
        .doc(email)
        .collection("usernotes")
        .doc(id)
        .delete()
        .then((value) {
      print("dletion sucess");
    });
  }
}
