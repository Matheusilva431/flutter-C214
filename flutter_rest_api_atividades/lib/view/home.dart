import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../model/comment.dart';
import '../controller/fetchComments.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Comments> futureComments;
  late int id = 1;
  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    futureComments = fetchCommentsById(id.toString());
  }

  void refresh() => setState(() {
        futureComments = fetchCommentsById(id.toString());
      });

  void nextComment() => setState(() {
        id++;
      });
  void previousComment() => setState(() {
        id--;
        if (id <= 0) {
          id = 1;
        }
      });

  List<Color> background = [
    Color.fromARGB(255, 161, 125, 190),
    Color.fromARGB(255, 117, 69, 157),
    Color.fromARGB(124, 108, 32, 128),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: background,
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
            )
          ),
          child: Center(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 130, bottom: 20),
                child:Text(
                  'Comment\nSearch',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                )
              ),
              FutureBuilder<Comments>(
                future: futureComments,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                  return outputCard(
                      snapshot.data!.body,
                      snapshot.data!.name,
                      snapshot.data!.email);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
                }
              ),
              navigationButtons()
            ]             
            ),
          ),
        ),
      );
    }
  Widget outputCard(String body, String name, String email) {
    TextStyle nameStyle =
        GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600);

    TextStyle contentStyle = GoogleFonts.openSans(fontWeight: FontWeight.w400);

    return SizedBox(
      width: 220,
      height: 230,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              SizedBox(
                  width: 220,
                  height: 60,
                  child: AutoSizeText(
                    maxLines: 2,
                    body,
                    style: nameStyle,
                    textAlign: TextAlign.justify,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Nome: $name',
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Email: $email',
                  style: contentStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ])),
      ),
    );
  }

  Widget navigationButtons() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {previousComment(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_left_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FloatingActionButton(
              onPressed: () => {nextComment(), refresh()},
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(side: BorderSide(color: Colors.white)),
              child: const Icon(Icons.arrow_right_outlined),
            ),
          ),
        ]));
  }
}
