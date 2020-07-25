import 'package:exampedia_app/pages/homescreen.dart';
import 'package:exampedia_app/pages/loading.dart';
import 'package:exampedia_app/services/auth.dart';
import 'package:exampedia_app/services/globals.dart';
import 'package:exampedia_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamlistScreen extends StatelessWidget {
  String region;
  ExamlistScreen({this.region});
  @override
  Widget build(BuildContext context) {

    String pathRef = "/ExamsDatabase/"+region+"/Exams/";
    final Collection<AllExams> examsRef = Collection<AllExams>(path: pathRef);
    return MultiProvider(
       providers: [
         StreamProvider<FirebaseUser>.value(value: AuthService().user)
        ],

        child: FutureBuilder(
            future: examsRef.getData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              var user = Provider.of<FirebaseUser>(context);
             
              print(user.toString());
              if (!snap.hasData) {
                print("User Screen snap no data ");
                return LoadingScreen();
              } else {
                print("Users Screen snap" + snap.data.toString());
                List<AllExams> examinfo = snap.data;


                return 
                Scaffold(
                  appBar: AppBar(),
                  body:
                Container(
            child: Column(
              children: examinfo.map((examInfo) => SmallExamCard(
                examname: examInfo.id,
                region: examInfo.region,
                qualification: examInfo.qualification??"NA",
                lastdate: examInfo.lastdate??"NA",
              )).toList()),
            )
                );
                   }
           }
        )
        );
  }
}

class Textcard extends StatelessWidget {
  Vacancy vacancy;
  Textcard({this.vacancy});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(vacancy.detail.toString()),
    );
  }
}