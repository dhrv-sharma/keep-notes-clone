import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';
import 'package:noteapp/sidedrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // staggered view 

class Home extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey =
      GlobalKey(); // global key for the app drawer opening you required drawer key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture:
          true, // enabling side drawer gesture for drawer in the  particular activity

      key:
          _drawerKey, // used for the side drawer key we have already initialized
      drawer:
          side_Drawer(), // drawer for that activity // Drawer() is an inbuilt class in the flutter
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  // search bar code
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                    //ButtonStyle is used to set the property of the button
                                    // here we have given the button style when user taps on it
                                    overlayColor: // sets the tap color
                                        MaterialStateColor.resolveWith(
                                            (states) => white.withOpacity(0.1)),
                                    shape: MaterialStateProperty
                                        .all< // sets the tap shape
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
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
              Container(
                width: MediaQuery.of(context).size.width,
                // trick to check size of container
                // decoration: BoxDecoration(
                //   border: Border.all(color: white)
                // ),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "All",
                      style: TextStyle(
                          color: white.withOpacity(0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
