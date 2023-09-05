// here we are creating the side drawer ui design

import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';

class side_Drawer extends StatefulWidget {
  const side_Drawer({super.key});

  @override
  State<side_Drawer> createState() => _side_DrawerState();
}

class _side_DrawerState extends State<side_Drawer> {
  @override
  Widget build(BuildContext context) {
    return
        // safe area brings the widget below the notification bar
        // now you can desgin the page as normal you make in flutter
      Drawer(// it is must 
      child: Container(
        decoration: const BoxDecoration(color: bgColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  "Google Keep",
                  style: TextStyle(
                      color: white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                // it is used here to draw a dividing line
                color: white.withOpacity(0.3),
              ),
              sectionOne(),
              SizedBox(height: 8,),
              sectiontwo(),
              SizedBox(height: 8,),
              sectionsetting()
              
            ],
          ),
        ),
      ),
    );
    ;
  }
}


Widget sectionOne(){
  return Container(
                margin: const EdgeInsets.only(
                    right:
                        10),
                        // line number 40 and 44 have this  so that on tap color looks better
                        // It uses MaterialStateProperty.all to specify that the background color should be the same for all button states.
                        // MaterialStateProperty.all is a utility function in Flutter that's commonly used to set a single value for a property for all possible states of a widget. It's often used for defining properties of interactive widgets like buttons, where the appearance or behavior may change based on different states, such as when the button is pressed, hovered over, or in its default state.
                child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle( // used for styling the text button 
                        backgroundColor: MaterialStateProperty.all( //
                            Colors.orangeAccent.withOpacity(0.3)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              const  RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            size: 27,
                            color: Colors.yellow[400],
                          ),
                          const SizedBox(
                            width: 27,
                          ),
                          Text(
                            "Notes",
                            style: TextStyle(
                                color: white.withOpacity(0.7), fontSize: 18),
                          )
                        ],
                      ),
                    )),
              );
}

Widget sectiontwo(){
  return Container(
                margin: const EdgeInsets.only(
                    right:
                        10),
                child: TextButton(
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.archive_outlined,
                            size: 27,
                            color: Colors.blue[400],
                          ),
                          const SizedBox(
                            width: 27,
                          ),
                          Text(
                            "Archive ",
                            style: TextStyle(
                                color: white.withOpacity(0.7), fontSize: 18),
                          )
                        ],
                      ),
                    )),
              );
}


Widget sectionsetting(){
  return Container(
                margin: const EdgeInsets.only(
                    right:
                        10),
                child: TextButton(
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 27,
                            color: Colors.red[400],
                          ),
                          const SizedBox(
                            width: 27,
                          ),
                          Text(
                            "Settings ",
                            style: TextStyle(
                                color: white.withOpacity(0.7), fontSize: 18),
                          )
                        ],
                      ),
                    )),
              );
}
