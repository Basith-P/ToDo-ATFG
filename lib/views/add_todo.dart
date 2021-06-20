import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/adapters/todo_adapter.dart';

class AddTodo extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title, description;

  submitData() async {
    if (widget.formkey.currentState.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.add(
        Todo(
          title: title,
          description: description,
          date: _dateTime,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Add task",
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: widget.formkey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Add title'),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Add description'),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _dateTime == null ? 'Pick a date' : _dateTime.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        ).then((value) {
                          setState(() {
                            _dateTime = value;
                          });
                        });
                      },
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Colors.black,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
                onPressed: submitData,
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.light_mode_rounded),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Tip: You can long press on an item to \n delete it!'),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('Connect with google calendar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
