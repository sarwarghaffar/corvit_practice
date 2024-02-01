import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  TextEditingController input = TextEditingController();

  List<String> messeges = [
    'Hello how are you',
    'im fine and how are you',
    'whats your name',
    'my name is Rizwan',
    'and your name?',
    'my name is Ali Raza',
  ];

  List<bool> isSender = [
    true,
    false,
    true,
    false,
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff23C440),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 650),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width*0.80,
                      child: TextFormField(
                        controller: input,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(
                            Icons.textsms_outlined,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Text',
                          hintStyle: GoogleFonts.abel(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                    onPressed: (){
                      final db = FirebaseDatabase.instance.ref();

                      db.child('Messages').get().then((value){
                        for(var item in value.children){
                          debugPrint('DATA: ${item.value}');
                        }
                      });
                    }, child: Text('Get Data')),
              ],
            ),
         Padding(
           padding: const EdgeInsets.only(left: 1400, top: 650),
           child: InkWell(
             onTap: (){
               messeges.add(input.text);
               isSender.add(true);
               setState(() {

               });

               final auth = FirebaseAuth.instance;
               final db = FirebaseDatabase.instance.ref();

               db.child('Messages').child(auth.currentUser!.uid).push().set({

                 "messages": input.text,
                 "isSender": true,
                 "time": '${DateTime.now()}',

                   });
               input.text='';

             },
             child: CircleAvatar(
               backgroundColor: Colors.blueAccent,
               radius: 30,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.blueAccent,
                 ),
                 width: MediaQuery.of(context).size.width*0.30,
                 child: Icon(
                   Icons.send,
                 ),
               ),
             ),
           ),
         ),

            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.8,
                  child: ListView.builder(
                    itemCount: messeges.length,
                      itemBuilder: (context,index){
                        return Bubble(
                            message: messeges[index],
                            sender: isSender[index],
                        );
                      },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {

  final message;
  final bool sender;

  const Bubble({
    super.key,
    required this.message,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Row(
        mainAxisAlignment:sender==true? MainAxisAlignment.start: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:sender==true? Colors.blue: Colors.white,
              ),
              child: Text(
                '${message}',
                style: GoogleFonts.poppins(
                  color:sender==true? Colors.white: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
