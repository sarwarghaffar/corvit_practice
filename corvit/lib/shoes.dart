import 'dart:html';

import 'package:corvit/main.dart';
import 'package:corvit/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';

class shoes extends StatefulWidget {
   shoes({super.key});

  @override
  State<shoes> createState() => _shoesState();
}

class _shoesState extends State<shoes> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
              'assets/images/loginburger.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.5),
              ),
              width: MediaQuery.of(context).size.width*0.90,
              height: MediaQuery.of(context).size.height*0.60,
            ),
          ),

          Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                      'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ),


          Positioned(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: TextFormField(

                  controller: email,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.yellowAccent,
                      ),
                    ),
                    hintText: 'Enter email',
                    hintStyle: GoogleFonts.abhayaLibre(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: TextFormField(

                    controller: password,
                    obscureText: true,

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.yellowAccent,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.abhayaLibre(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFC3B0B),
                  ),
                    onPressed: (){

                    debugPrint ('${email.text}');
                    debugPrint ('${password.text}');

                    final auth = FirebaseAuth.instance;

                    auth.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                    );

                    if(auth.currentUser!=null){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>search()));
                    }

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                          'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){

              final db = FirebaseDatabase.instance.ref();
              db.child('Students').child('Khan').set({
                "rollNumber":"12",
                "FatherName":"Ali Abbas",
                "id":"5",
              });
          },
              child: Text('enter'),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ElevatedButton(onPressed: (){

                  check==false? check=true : check=false;
                  setState(() {

                  });
                },
                    child: Text('Change Color'),
                ),
                Text(
                  'Hello corvit',
                  style: GoogleFonts.purplePurse(

                    color: check==false? Colors.yellowAccent : Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
