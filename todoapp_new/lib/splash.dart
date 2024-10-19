import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp_new/listpage.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => todolistpage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.amber),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assest/to-do-list.png",
                    height: 100,
                    width: 80,
                  ),
                 
                ],
              ),
               SizedBox(
                    width: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "TODO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),

            ],
          )),
    );
  }
}
