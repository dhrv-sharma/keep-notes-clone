import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/editnote.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/model/mynote.dart';
import 'package:noteapp/services/db.dart';

class noteview extends StatefulWidget {
  late note? Note;

  // constructor will take a particular note

  noteview({required this.Note});

  // noteview({required this.Note});
  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.Note!.pin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.3,
        actions: [
          // these put the icons over the activity action bar
          IconButton(
            onPressed: () async {
              await noteDatabase.instance.pinNote(widget.Note);
              Navigator.pop(context);
            },
            icon: widget.Note!.pin ? const Icon(Icons.push_pin): Icon(Icons.push_pin_outlined)  ,
            splashRadius:
                17, // when user tap over the button then this tap shape radius is set by this property
          ),
          IconButton(
            onPressed: () async{
              await noteDatabase.instance.archiveNote(widget.Note);
              Navigator.pop(context);

            },
            icon: widget.Note!.isArchived ?const  Icon(Icons.archive) :const  Icon(Icons.archive_outlined),
            splashRadius: 17,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => editNote(Note: widget.Note),));
            },
            icon: const Icon(Icons.edit_outlined),
            splashRadius: 17,
          ),
          IconButton(
            onPressed: () async {
              await noteDatabase.instance.deleteNote(widget.Note);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_forever_outlined),
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
              child: Text(widget.Note!.title,
                  style: const TextStyle(
                      color: white, fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Text(
                widget.Note!.content,
                style: const TextStyle(color: white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
