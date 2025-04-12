import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:NoteToDo/Screens/addNoteScreen.dart';
import '../models/note.dart';
import '../services/databaseHelper.dart';
import 'dart:math';

class Noteslistscreen extends StatefulWidget {
  const Noteslistscreen({super.key});

  @override
  State<Noteslistscreen> createState() => _NoteslistscreenState();
}

class _NoteslistscreenState extends State<Noteslistscreen> {
  List<Note> _allNotes = [];
  List<Note> _filteredNotes = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();

    // Écoute les changements dans la barre de recherche
    _searchController.addListener(() {
      _filterNotes();
    });
  }

  Future<void> _loadNotes() async {
    final notes = await DatabaseHelper().getNotes();
    setState(() {
      _allNotes = notes;
      _filteredNotes = notes;
    });
  }

  void _filterNotes() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredNotes = _allNotes.where((note) {
        final titleMatch = note.title.toLowerCase().contains(query);
        final contentMatch = note.content.toLowerCase().contains(query);
        return titleMatch || contentMatch;
      }).toList();
    });
  }

  Future<void> _deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listes des Notes'),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher une note...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),

          // Grille des notes
          Expanded(
            child: _filteredNotes.isEmpty
                ? const Center(
              child: Text('Aucune note correspondante.'),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: _filteredNotes.length,
              itemBuilder: (context, index) {
                final note = _filteredNotes[index];

                // Génération d'une couleur aléatoire
                final randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNoteScreen(note: note),
                      ),
                    ).then((_) => _loadNotes());
                  },
                  child: Card(
                    color: randomColor.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                           SizedBox(height: 8.0.h),
                          Expanded(
                            child: Text(
                              note.content,
                              style:  TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.black54,
                              ),
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                           SizedBox(height: 8.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.black54,),
                                onPressed: () async {
                                  await _deleteNote(note.id!);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFEFEFEF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          ).then((_) => _loadNotes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
