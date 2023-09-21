import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/auth.dart';
import 'package:noteapp/home.dart';
import 'package:noteapp/login.dart';

class newUser extends StatefulWidget {
  const newUser({super.key});

  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  TextEditingController contrlName = TextEditingController();
  TextEditingController contrlPassword = TextEditingController();
  TextEditingController contrlConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.grey[300]), // Replace with your desired color
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const SizedBox(
                height: 30,
              ),
              Center(child: Image.asset('images/googleKeep.png')),

              const SizedBox(
                height: 25,
              ),

              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Create a new account for more services",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrlName,
                  decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      fillColor: Colors.grey.shade200,
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 7),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrlPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      fillColor: Colors.grey.shade200,
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600)),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 7),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrlConfirm,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      fillColor: Colors.grey.shade200,
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600)),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  print(contrlName.text);
                  print(contrlPassword.text);

                  try {
                    if (contrlConfirm.text == contrlPassword.text) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });

                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: contrlName.text,
                          password: contrlPassword.text);

                          
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> auth()));
                    }
                    else{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.purple,
                              title: const Text(
                                "Password Does Not Match",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });

                    }
                  } on FirebaseAuthException catch (e) {
                    Navigator.pop(context);

                    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                      // print("user not found");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.purple,
                              title: const Text(
                                "Incorrect Credential",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aready user?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
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
