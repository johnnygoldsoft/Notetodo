import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/todo.dart';
import '../services/databaseHelper.dart';
import '../services/notificationService.dart';
import 'package:intl/intl.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _saveTodo() async {
    debugPrint("envoyer ............");
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le titre est obligatoire.')),
      );
      return;
    }

    final newTodo = Todo(
      title: _titleController.text,
      description: _descriptionController.text,
      reminder: _selectedDateTime,
    );

    // Enregistrer dans la base de données
    await DatabaseHelper().insertTodo(newTodo);

    // Programmer une notification si un rappel est défini

    if (_selectedDateTime != null) {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000; // ID unique
      await NotificationService().scheduleNotification(
          id: id,
          title: 'Rappel : ${newTodo.title}',
          body:
              'C\'est l\'heure de terminer votre tâche ! \n ${newTodo.description}',
          scheduledTime: _selectedDateTime!,
          imagePath: "assets/images/icone.png");
    }

    // Retour à l'écran précédent
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une tâche'),
        actions: [
          CircleAvatar(
            backgroundColor:  Color(0xFFEFEFEF),
              child: IconButton(
            onPressed: _saveTodo,
            icon: const Icon(Icons.save),
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0x25000000),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Titre',
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description (facultatif)',
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _selectedDateTime == null
                              ? 'Aucun rappel sélectionné'
                              : 'Rappel : ${DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!)}',
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDateTime(context),
                      child: Text('Choisir une date et heure'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
