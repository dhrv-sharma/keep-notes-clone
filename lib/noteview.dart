import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/editnote.dart';
import 'package:noteapp/home.dart';

class noteview extends StatefulWidget {
  const noteview({super.key});

  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.3,
        actions: [ // these put the icons over the activity action bar 
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.push_pin_outlined),
            splashRadius: 17, // when user tap over the button then this tap shape radius is set by this property
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive_outlined),
            splashRadius: 17, 
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>editNote()));

            },
            icon: const Icon(Icons.edit_outlined),
            splashRadius: 17,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: const Text("HEADING",
                  style: TextStyle(
                      color: white, fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Text(
                note1,
                style: const TextStyle(color: white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
