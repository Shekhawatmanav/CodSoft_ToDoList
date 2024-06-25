import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter/data/database.dart';
import 'package:todo_flutter/util/dialog_box.dart';
import '../util/todo_tile.dart';
class HomePage extends StatefulWidget{
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage>{
    final _myBox = Hive.box('mybox');

    final _controller = TextEditingController();

    //list of todo task
    TodoDatabase db = TodoDatabase();

    @override
  void initState() {
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else {
      db.loadData();
    }
    super.initState();
  }

    void checkBoxChanged(bool? value , int index){
      setState(() {
        db.toDoList[index][1] = !db.toDoList[index][1];
      });
      db.updateDatabase();
     
    }

    //save new task
    void saveNewTask(){
      setState(() {
        db.toDoList.add([_controller.text, false ]);
        _controller.clear();
      });
       Navigator.of(context).pop();
       db.updateDatabase();
    }

    void createNewtask(){
      showDialog(context: context, builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      });
    }

    void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateDatabase();

    }



    @override
    Widget build (BuildContext context){
      return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          title: Text("TO DO"),
          elevation: 0,
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: createNewtask
          ,child: Icon(Icons.add),
          ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context,index){
            return TodoTile(taskname: db.toDoList[index][0], taskcompleted: db.toDoList[index][1], onChanged: (value) => checkBoxChanged(value, index), deletefunction: (context) => deleteTask(index),
            );

          },
        ),
      );
  }
}