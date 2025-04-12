import 'package:NoteToDo/Screens/creditScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:NoteToDo/Screens/notesListScreen.dart';
import 'package:NoteToDo/Screens/todoListScreen.dart';
import '../services/databaseHelper.dart';
import '../models/todo.dart';
import 'addToDoScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {

    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [

    Noteslistscreen(),
    Todolistscreen(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text("Note ToDo"), actions: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Creditscreen()),
              );
            },
            child: Image.asset("assets/images/icone.png", width: 30.0, height: 30.0,)),
      )],),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        backgroundColor: Color(0xFFEFEFEF),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Prise de Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tâche Liste',
          ),

        ],
      ),
    );
  }
}
