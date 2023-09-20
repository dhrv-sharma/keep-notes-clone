import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/createnote.dart';
import 'package:noteapp/noteview.dart';
import 'package:noteapp/searchpage.dart';
import 'package:noteapp/services/db.dart';
import 'package:noteapp/services/services.dart';
import 'package:noteapp/sidedrawer.dart';
import 'model/mynote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // staggered view



List<note> noteUser = [];

List<note> pinUser = [];

List<note> listUser = [];

bool isLoading = true;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey =
      GlobalKey(); // global key for the app drawer opening you required drawer key

//  ways to use services.dart
  // Future cretaeEntry() async{
  //   await Notedata.instance.InsertEntry();
  // }

  // Future getNotes() async{
  //   await Notedata.instance.readNotes();

  // }

  // Future getOneNote() async{
  //   await Notedata.instance.readOneNote(3);
  // }

  // Future updateOneNote() async{
  //   await Notedata.instance.updateNote(3);
  // }

  // Future deletenote() async{
  //   await Notedata.instance.deleteNote(1);
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   cretaeEntry();
  //   deletenote();
  //   updateOneNote();
  //   getOneNote();
  //   getNotes();

  // }

  bool delayed() {
    setState(() {
      isLoading = false;
    });

    return true;
  }

  Future cretaeEntry(note noteEx) async {
    await noteDatabase.instance.InsertEntry(noteEx);
  }

  Future getNotes() async {
    noteUser = await noteDatabase.instance.readNotes();

    Future.delayed(Duration(seconds: 1), delayed);
  }

  Future getOneNote(int id) async {
    await noteDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(note noteEx) async {
    await noteDatabase.instance.updateNote(noteEx);
  }

  Future deletenote(note noteEx) async {
    await noteDatabase.instance.deleteNote(noteEx);
  }

  Future getpin() async {
    pinUser = await noteDatabase.instance.pinedNotes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cretaeEntry(note(
    //     pin: false,
    //     title: "asia cup",
    //     content: "pakistan is out of the asia cupt",
    //     createdTime: DateTime.now()));
    getNotes();
    getpin();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: bgColor), // Replace with your desired color
    );
    return  isLoading
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              // inbuilt class for the floating button
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newNote()));
              },
              backgroundColor: cardColor,
              child: const Icon(
                Icons.add,
                size: 45,
              ),
            ),
            endDrawerEnableOpenDragGesture:
                true, // enabling side drawer gesture for drawer in the  particular activity

            key:
                _drawerKey, // used for the side drawer key we have already initialized
            drawer:
                side_Drawer(), // drawer for that activity // Drawer() is an inbuilt class in the flutter
            backgroundColor: bgColor,
            body: SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  // making app scrollable
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => searchView()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchView()));
                          },
                          child: Container(
                              // search bar code
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // to get the width of the device
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 3)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // it is used when you have to put one object at start and other at the end
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _drawerKey.currentState!
                                                .openDrawer(); // function to open drawer from the button
                                          },
                                          icon: const Icon(
                                            Icons.menu,
                                            color: white,
                                          )),
                                      Container(
                                        height: 55,
                                        width: 205,
                                        decoration: const BoxDecoration(
                                            // border: Border.all(color: Colors.white)
                                            ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Search Your Notes ",
                                              style: TextStyle(
                                                  color: white.withOpacity(
                                                      0.5), // used to set the transparency of the color
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(width: 30,),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            style: ButtonStyle(
                                                //ButtonStyle is used to set the property of the button
                                                // here we have given the button style when user taps on it
                                                overlayColor: // sets the tap color
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            white.withOpacity(
                                                                0.1)),
                                                shape: MaterialStateProperty
                                                    .all< // sets the tap shape
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ))),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.grid_view,
                                              color: white,
                                            )),
                                        const SizedBox(width: 10),
                                        const CircleAvatar(
                                          backgroundColor: white,
                                          radius:
                                              16, // size define of circular avatar image
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // trick to check size of container
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: white)
                        // ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "All",
                                  style: TextStyle(
                                      color: white.withOpacity(0.5),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                    style: ButtonStyle(
                                        //ButtonStyle is used to set the property of the button
                                        // here we have given the button style when user taps on it
                                        overlayColor: // sets the tap color
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    white.withOpacity(0.1)),
                                        shape: MaterialStateProperty
                                            .all< // sets the tap shape
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ))),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                        getNotes();
                                        getpin();
                                        listUser.clear();
                                        listUser.addAll(pinUser);
                                        listUser.addAll(noteUser);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.refresh_outlined,
                                      size: 23,
                                      color: white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      highlighted_nte(),
                      nonhiglight_nte(),
                      Container(
                        // here to make centre the thing List View on centre we did a container so that it can take whole space width
                        width: MediaQuery.of(context).size.width,
                        // trick to check size of container
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: white)
                        // ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "List View",
                              style: TextStyle(
                                  color: white.withOpacity(0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      listviewNotes()
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Widget nonhiglight_nte() {
  return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: StaggeredGridView.countBuilder(
          // here main axis is vertical and the cross axis is horizontal like column
          physics:
              NeverScrollableScrollPhysics(), // its internal scrolling get closed
          shrinkWrap: true, // it is always neccessary
          itemCount: noteUser.length, // gives the number of count
          mainAxisSpacing: 12, // gives space between item in main axis
          crossAxisSpacing: 12, // gives space between item in  cross axis
          crossAxisCount: 4, // means 4 columns would be there
          staggeredTileBuilder: (index) => const StaggeredTile.fit(
              2), // this number of column a tile will get scatterred // vertivally it will takes space as per its sixe
          itemBuilder: (context, index) => InkWell(
                // same as of listview builder
                // widget ui of one particular tile
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              noteview(Note: noteUser[index])));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(noteUser[index].title,
                          style: const TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        noteUser[index].content.length > 250
                            ? "${noteUser[index].content.substring(0, 250)}......."
                            : noteUser[index].content,
                        style: const TextStyle(color: white),
                      )
                    ],
                  ),
                ),
              )));
}

Widget highlighted_nte() {
  return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: StaggeredGridView.countBuilder(
          // here main axis is vertical and the cross axis is horizontal like column
          physics:
              NeverScrollableScrollPhysics(), // its internal scrolling get closed
          shrinkWrap: true, // it is always neccessary
          itemCount: pinUser.length, // gives the number of count
          mainAxisSpacing: 12, // gives space between item in main axis
          crossAxisSpacing: 12, // gives space between item in  cross axis
          crossAxisCount: 4, // means 4 columns would be there
          staggeredTileBuilder: (index) => const StaggeredTile.fit(
              2), // this number of column a tile will get scatterred // vertivally it will takes space as per its sixe
          itemBuilder: (context, index) => InkWell(
                // same as of listview builder
                // widget ui of one particular tile
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              noteview(Note: pinUser[index])));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color:
                          index.isEven ? Colors.green[900] : Colors.blue[900],
                      border: index.isEven
                          ? Border.all(color: Colors.green.shade900)
                          : Border.all(color: Colors.blue.shade900),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pinUser[index].title,
                          style: const TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pinUser[index].content.length > 250
                            ? "${pinUser[index].content.substring(0, 250)}......."
                            : pinUser[index].content,
                        style: const TextStyle(color: white),
                      )
                    ],
                  ),
                ),
              )));
}

Widget listviewNotes() {
  return ListView.builder(
      physics:
          NeverScrollableScrollPhysics(), // its internal scrolling get closed
      shrinkWrap: true, // it is always neccessary
      itemCount: listUser.length, // gives the number of count

      itemBuilder: (context, index) => InkWell(
            // same as of listview builder
            // widget ui of one particular tile
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => noteview(Note: listUser[index])));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: index.isEven ? Colors.green[900] : Colors.blue[900],
                  border: index.isEven
                      ? Border.all(color: Colors.green.shade900)
                      : Border.all(color: Colors.blue.shade900),
                  borderRadius: BorderRadius.circular(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listUser[index].title,
                      style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    listUser[index].content.length > 250
                        ? "${listUser[index].content.substring(0, 250)}......."
                        : listUser[index].content,
                    style: const TextStyle(color: white),
                  )
                ],
              ),
            ),
          ));
}
