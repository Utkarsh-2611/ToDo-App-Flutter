import 'package:flutter/material.dart';
import 'package:todo_application/util/my_button.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancle;
  DialogueBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancle,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Add a new task",
              border: OutlineInputBorder()
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            MyButton(text: "Save", onPressed: onSave),

            const SizedBox(width: 10),

            MyButton(text: "Cancle", onPressed: onCancle),
          ],)
        ],),
        ),
    );
  }
}