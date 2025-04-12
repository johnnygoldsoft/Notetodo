import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/databaseHelper.dart';

class AddNoteScreen extends StatefulWidget {

  final Note? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nouvelle Note' : 'Modifier Note'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 10.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFFEFEFEF),
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  final title = _titleController.text.trim();
                  final content = _contentController.text.trim();

                  if (title.isNotEmpty && content.isNotEmpty) {
                    final note = Note(
                      id: widget.note?.id,
                      title: title,
                      content: content,
                      createdAt: DateTime.now(),
                    );

                    if (widget.note == null) {
                      await DatabaseHelper().insertNote(note);
                    } else {
                      await DatabaseHelper().updateNote(note);
                    }

                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
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
              children: [

                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Titre', border: InputBorder.none),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Contenu',border: InputBorder.none),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
