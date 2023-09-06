import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';

class editNote extends StatefulWidget {
  const editNote({super.key});

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.3,
        actions: [
          IconButton(
            onPressed: () {},
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
                cursorColor: white, // when clicked what will be the color of user 
                style: const TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold), // style of user input text
                decoration: InputDecoration(
                    border: InputBorder.none, // sets the border of the field
                    focusedBorder: InputBorder.none, // when the field get tapped then what will be border
                    errorBorder: InputBorder.none, // obviously the border error 
                    disabledBorder: InputBorder.none, // when user has left action over the text field 
                    hintText: "Title",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.8))),
              ),
            ),
            Container(
              height: 300, // it is done so that when user tap on an area where this container lies than it text field as well

              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: TextField(
                keyboardType: TextInputType.multiline, // user enter button act as new line
                minLines: 50, // minimum lines in field 
                maxLines: null, // max lines in field 
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
