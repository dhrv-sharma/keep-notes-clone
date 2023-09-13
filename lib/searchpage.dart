import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';

class searchView extends StatefulWidget {
  const searchView({super.key});

  @override
  State<searchView> createState() => _searchViewState();
}

class _searchViewState extends State<searchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: white.withOpacity(0.1)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context); // ends the particular current activity
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: white,
                  )),
              Expanded(
                // it is neccassry to use when Row widget is used in TextField
                child: TextField(
                  style: const TextStyle(
                      // styling for the inoout text
                      color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none, // sets the border of the field
                      focusedBorder: InputBorder
                          .none, // when the field get tapped then what will be border
                      errorBorder:
                          InputBorder.none, // obviously the border error
                      disabledBorder: InputBorder
                          .none, // when user has left action over the text field
                      hintText: "Search Your Notes ",
                      hintStyle: TextStyle(
                          color: white.withOpacity(
                              0.5), // used to set the transparency of the color
                          fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
