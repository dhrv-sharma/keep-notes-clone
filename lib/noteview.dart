import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/editnote.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/model/mynote.dart';
import 'package:noteapp/services/db.dart';

late bool pinned;
late bool archived;

class noteview extends StatefulWidget {
  late note? Note;

  // constructor will take a particular note

  noteview({required this.Note});

  // noteview({required this.Note});
  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {
  late note? view;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view = widget.Note;
    pinned = view!.pin;
    archived = view!.isArchived;
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
              note? temp = await noteDatabase.instance.pinNote(view);
              // print("doing");
              // Navigator.pop(context);
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> noteview(Note: widget.)));
              view = temp;
              pinned = !pinned;

              setState(() {});
            },
            icon: pinned
                ? const Icon(Icons.push_pin)
                : const Icon(Icons.push_pin_outlined),
            splashRadius:
                17, // when user tap over the button then this tap shape radius is set by this property
          ),
          IconButton(
            onPressed: () async {
              note? temp = await noteDatabase.instance.archiveNote(view);
              // print("doing");
              // Navigator.pop(context);
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> noteview(Note: widget.)));
              view = temp;
              archived = !archived;

              print("second ${view!.isArchived}");

              setState(() {});
            },
            icon: archived
                ? const Icon(Icons.archive)
                : const Icon(Icons.archive_outlined),
            splashRadius: 17,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editNote(Note: view),
                  ));
            },
            icon: const Icon(Icons.edit_outlined),
            splashRadius: 17,
          ),
          IconButton(
            onPressed: () async {
              await noteDatabase.instance.deleteNote(view);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_forever_outlined),
            splashRadius: 17,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: Text(view!.title,
                    style: const TextStyle(
                        color: white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: Text(
                  view!.content,
                  style: const TextStyle(color: white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
