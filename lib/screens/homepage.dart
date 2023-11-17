import 'dart:io';

import 'package:flutter/material.dart';

import 'package:nfc_app/screens/readnfc.dart';
import 'package:nfc_app/screens/writenfc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        actions: [
          Text(""),
          IconButton(
              onPressed: () {
                exit(0);
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.cyanAccent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "NFC",
                style: TextStyle(
                    fontSize: 46, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/nfc.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: const Color.fromARGB(255, 0, 0, 0),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: ((context) => ReadNfc())));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              offset: Offset(3, 3),
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 7, 183, 206),
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Image.asset("assets/phone.png"),
                          const Text(
                            "  READ  ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WriteNfc()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(187, 0, 0, 0),
                              offset: Offset(3, 3),
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 7, 183, 206),
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Image.asset("assets/phone.png"),
                          const Text(
                            "  WRITE   ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
