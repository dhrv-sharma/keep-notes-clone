import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:noteapp/colors.dart';

class settingView extends StatefulWidget {
  const settingView({super.key});

  @override
  State<settingView> createState() => _settingViewState();
}

class _settingViewState extends State<settingView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Setting View"),
        backgroundColor: bgColor,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Sync ",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Spacer(), // gives max space betwwen two widget
                Transform.scale( // it is used to scale the widget from its normal size 
                  scale: 1.5, // this would scale measurement 
                  child: Switch.adaptive(
                      value: value,
                      onChanged: (SwtichValue) => setState(() {
                            this.value =
                                SwtichValue; // this function provides a SwitchValue when the state get change
                          })),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
