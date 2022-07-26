import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/pages/add_note_page.dart';
import 'package:note_app/pages/edit_note_page.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text("NOTEBOOK",
            style: GoogleFonts.ibarraRealNova(
              color: const Color(0xff2d2d2d),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            )),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColorDark,
            )),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final receivedData = snapshot.data!.docs;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.hasData ? receivedData.length : 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditNotePage(docToEdit: receivedData[index])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Color(0xffedf6f9),
                            // gradient: LinearGradient(
                            //   colors: [Color(0xff2b2d42),Color(0xff8d99ae)],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            //   ),
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: Text(
                                receivedData[index]['title'],
                                style: GoogleFonts.ibarraRealNova(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  //color: Color(0xffff469c)
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                              const SizedBox(height: 8.0),
                              Flexible(
                                child: Text(
                                  receivedData[index]['content'],
                                  style: GoogleFonts.ibarraRealNova(
                                      fontSize: 21,
                                      color: const Color.fromARGB(
                                          255, 50, 58, 65)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AddNotePage()));
          },
          child: const Icon(
            Icons.add,
            size: 36.0,
          ),
          backgroundColor: Theme.of(context).primaryColorDark),
    );
  }
}
