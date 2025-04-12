import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/todo.dart';
import '../services/databaseHelper.dart';
import 'addToDoScreen.dart';

class Todolistscreen extends StatefulWidget {
  const Todolistscreen({super.key});

  @override
  State<Todolistscreen> createState() => _TodolistscreenState();
}

class _TodolistscreenState extends State<Todolistscreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper().getTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _deleteTodo(int id) async {
    await DatabaseHelper().deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Tâches')),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];

                // Génération d'une couleur aléatoire
                final randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  padding: EdgeInsets.all(0),


                  decoration: BoxDecoration(
                      color: randomColor.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x25000000),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    title: Text(todo.title, style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15.sp,
                    )),
                    subtitle: Row(
                      children: [
                        Icon(Icons.alarm,size: 20.0,),
                        SizedBox(width: 10.0.w,),
                        Text(
                            todo.reminder != null ? todo.reminder.toString() : 'Pas de rappel'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.black54,),
                      onPressed: () => _deleteTodo(todo.id!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFEFEFEF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          ).then((_) => _loadTodos());
        },
      ),
    );
  }
}
