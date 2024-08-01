import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/data/data_base.dart';
import 'package:todo_application/util/dialogue_box.dart';
import 'package:todo_application/util/to_do_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

@override
  void initState() {

    if(_mybox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

final _controller=TextEditingController();


   void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
   }

   void saveNewTask(){
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();  
   }



   void createNewTask(){
    showDialog(
      context: context,
       builder: (context) {
         return DialogueBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancle: () => Navigator.of(context).pop (),
         );
       },
       );
   }

   void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightGreen,
        // ignore: prefer_const_constructors
        title: Center(
          child: Text(
            "To Do",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoList(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );    
        },
      ),
    );
  }
}
