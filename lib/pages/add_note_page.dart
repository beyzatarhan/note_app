import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColorDark,
            )),
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          TextButton(
              onPressed: () async {
                FirebaseFirestore.instance.collection('notes').add({
                  'title': title.text,
                  'content': content.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text(
                "Save",
                style: GoogleFonts.ibarraRealNova(
                    fontSize: 18, color: Theme.of(context).primaryColorDark),
              )),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  icon: Icon(Icons.title_rounded),
                  hintText: "Title",
                ),
                style: GoogleFonts.ibarraRealNova(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: "Content",
                  ),
                  style: GoogleFonts.ibarraRealNova(
                    fontSize: 21,
                    color: const Color.fromARGB(255, 50, 58, 65),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
