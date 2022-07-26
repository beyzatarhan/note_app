import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/pages/note_page.dart';
import 'package:note_app/widget/on_hover_button.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColorLight: Colors.white,
          primaryColorDark: const Color(0xffe76f51),
          primaryColor: const Color(0xff03071e)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("NOTEBOOK",
            style: GoogleFonts.ibarraRealNova(
              color: const Color(0xff2d2d2d),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            )),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                child: const RiveAnimation.asset(
                    'animations/1766-3488-projects-icon.riv'),
              ),
              const SizedBox(
                height: 25,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NotePage()));
                },
                label: Text(
                  'Create notes.',
                  style: GoogleFonts.ibarraRealNova(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                backgroundColor: Theme.of(context).primaryColorLight,
                foregroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.notes_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
