import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/auth.dart';
import 'package:noteapp/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:noteapp/login.dart';
import 'package:noteapp/services/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FireDB test=FireDB();
  // test.createNoteFirestore(FirebaseAuth.instance.currentUser!.email,"5");
  // test.updateNoteFirestore("this is word cup", "year", FirebaseAuth.instance.currentUser!.email, "3");
  // test.deletedNoteFirestore(FirebaseAuth.instance.currentUser!.email, "4");
  // test.getAllStoredNote(FirebaseAuth.instance.currentUser!.email.toString());

  
  

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: auth(),
  ));
}
