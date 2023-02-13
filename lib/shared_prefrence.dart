import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'note_list_screen.dart';

class SharedPrefrence extends StatefulWidget {
  const SharedPrefrence({Key? key}) : super(key: key);

  @override
  State<SharedPrefrence> createState() => _SharedPrefrenceState();
}

class _SharedPrefrenceState extends State<SharedPrefrence> {
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPrefrence Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: notesController,
              decoration: const InputDecoration(hintText: 'Enter Notes'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setNotesData(notesController.text);
                },
                child: const Text("Save")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NoteScreen()));
                },
                child: const Text("View Note")),
          ],
        ),
      ),
    );
  }

  Future<void> setNotesData(noteValue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('notesData', noteValue);
  }
}
