import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController contrlName = TextEditingController();
  TextEditingController contrlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey[300]), // Replace with your desired color
    );
    
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
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
                  "Welcome back you've been missed",
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
                      
                      enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      fillColor: Colors.grey.shade200,
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.grey[500],fontWeight:FontWeight.w600)),
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
                      enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200)),
                      fillColor: Colors.grey.shade200,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[500],fontWeight:FontWeight.w600 )),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password ?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async{
                  print(contrlName.text);
                  print(contrlPassword.text);
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: contrlName.text, password: contrlPassword.text);
                  },
                child: Container(
                  decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.all(25),
                  child:const  Center(
                      child:  Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        " Or continue With",
                        style: TextStyle(color: Colors.grey[700]),
                      )),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:() async{
                        
                        
                      } ,
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(16)),
                          child: Image.asset(
                            "images/logoGoogle.png",
                            height: 52,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16)),
                        child: Image.asset(
                          "images/appleLogo.png",
                          height: 52,
                        ))
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
