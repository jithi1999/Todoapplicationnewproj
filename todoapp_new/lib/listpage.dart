import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_new/edittask.dart';

class todolistpage extends StatefulWidget {
  const todolistpage({super.key});

  @override
  State<todolistpage> createState() => _todolistpageState();
}

class _todolistpageState extends State<todolistpage> {
  Future<void> loadingTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('workingtask');
    List<String>? complTask = prefs.getStringList('compledtask');
    print(taskList);

    // List<String>? todoList = prefs.getStringList('todoList');
    if (taskList != null) {
      setState(() {
        task = taskList;
      });
    }
    if (complTask != null) {
      setState(() {
        Completed_task = complTask;
      });
    }

    // print(taskList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingTodoList();
  }

  TextEditingController addnew = TextEditingController();
  List<String> task = [];
  List<String> Completed_task = [];

  Future<void> UpdateList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('workingtask', task);
    prefs.setStringList('compledtask', Completed_task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.amber,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "lib/assest/to-do-list.png",
                        height: 100,
                        width: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "My Task",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: addnew,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.add),
                                fillColor: Color.fromARGB(255, 248, 248, 248),
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: 'Enter a search term',
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (addnew.text.isNotEmpty) {
                                task.add(addnew.text);
                                addnew.clear();
                                UpdateList();
                              } else {
                                addnew.clear();
                              }
                            });
                          },
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.blue, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Task List",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: task.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: Container(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Completed_task.add(
                                                      task[index]);
                                                  task.removeAt(index);
                                                  UpdateList();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 255, 139, 7),
                                              )),
                                          Text(task[index]),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            edittasklist(
                                                              taskindex: index,
                                                            )));
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 11, 56, 161),
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  task.removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 255, 7, 7),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Completed Task",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: Completed_task.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 20),
                              child: Container(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  task.add(
                                                      Completed_task[index]);
                                                  Completed_task.removeAt(
                                                      index);
                                                  UpdateList();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Color.fromARGB(
                                                    255, 7, 255, 11),
                                              )),
                                          new RichText(
                                            text: new TextSpan(
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: Completed_task[index],
                                                  style: new TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 1, 1, 1),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Completed_task.removeAt(
                                                      index);
                                                  UpdateList();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 255, 7, 7),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
