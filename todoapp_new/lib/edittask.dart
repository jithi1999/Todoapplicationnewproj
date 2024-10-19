import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_new/listpage.dart';

class edittasklist extends StatefulWidget {
  final int taskindex;
  const edittasklist({super.key, required this.taskindex});

  @override
  State<edittasklist> createState() => _edittasklistState();
}

class _edittasklistState extends State<edittasklist> {
  TextEditingController editdata = TextEditingController();
  List<String> taskediting = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadingTodoList();
    });
  }

  Future<void> loadingTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('workingtask');

    taskediting = taskList!;
    editdata.text = taskList[widget.taskindex];
  }

  Future<void> taskUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('workingtask');
    taskList?[widget.taskindex] = editdata.text;
    await prefs.setStringList('workingtask', taskList!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(208, 255, 255, 255),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 500,
                            width: 600,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.amber,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Edit Your Task",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: editdata,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(255, 0, 0, 0)),
                                          decoration: InputDecoration(
                                              fillColor:
                                                  Color.fromARGB(255, 248, 248, 248),
                                              filled: true,
                                              border: OutlineInputBorder(),
                                              hintStyle: TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 160,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color.fromARGB(236, 219, 11, 11)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        todolistpage()));
                                          },
                                          child: Text(
                                            "Cancle",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 160,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color.fromARGB(245, 57, 124, 2)),
                                          onPressed: () {
                                            if (editdata.text.isNotEmpty) {
                                              taskUpdate();
              
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          todolistpage()));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: const Color.fromARGB(
                                                      255, 255, 28, 7),
                                                  content: Text(
                                                    'This Task field cannot be left empty. Please enter a value.',
                                                    style: TextStyle(
                                                        color: const Color.fromARGB(
                                                            255, 255, 255, 255)),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
