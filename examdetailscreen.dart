import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:exampedia_app/pages/homescreen.dart';
import 'package:exampedia_app/pages/webviewscreen.dart';
import 'package:exampedia_app/services/auth.dart';
import 'package:exampedia_app/services/globals.dart';
import 'package:exampedia_app/services/models.dart';
import 'package:exampedia_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


import 'loading.dart';

class ExamdetailScreen extends StatelessWidget {
  String examtitle;
  String region;
  AllExams currentexam;
  ExamdetailScreen({this.examtitle,this.region});
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size; 
    final width = size.width;
    final height = size.height;
    String pathRef = "/ExamsDatabase/"+region+"/Exams/";
    final Collection<AllExams> examsRef = Collection<AllExams>(path: pathRef);
    return
    MultiProvider(
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
                for (var i = 0; i < examinfo.length; i++) {
                  if (examinfo[i].id == examtitle) {
                      currentexam = examinfo[i];
                  }
                }
                
                print(currentexam.postdate);

                return 
    Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (result) {
    if (result == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    }
},
            itemBuilder: (context)=>
            [
              PopupMenuItem(
        child:Row(
          children: <Widget>[
        Icon(Icons.book,color: Colors.black,),
        SizedBox(width:width*0.02),
        Text("Bookmark Post"),
          ],
        ) ,
        value: 0,
      ),
      PopupMenuItem(
        child:FlatButton(
          onPressed: () async => await _shareText(), 
          child: 
         
        Row(
          children: <Widget>[
        Icon(Icons.share,color: Colors.black,),
        SizedBox(width:width*0.02),
        Text("Share Post"),
          ],
        ) ,
         ),
        //value: 0,
      ),
      /*
      PopupMenuItem(
        child:
        Row(
          children: <Widget>[
        Icon(Icons.link,color: Colors.black,),
        SizedBox(width:width*0.02),
        Text("Copy Link"),
          ],
        ) ,
        value: 0,
      ),
      */
            ]
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(


                    icon: new Icon(Icons.search), 
                   
                    title: Text('Search')
                    ),
       /*
         BottomNavigationBarItem(
                    icon:new Icon(Icons.book),
                   title: Text(''),
                  ),
         BottomNavigationBarItem(
                    icon:new Icon(Icons.share),
                   title: Text(''),
                  ),
            */     
         BottomNavigationBarItem(
                    icon: new Icon(Icons.dehaze),
                   title: Text('More')
                  ),
        ],
        currentIndex: 0,
        onTap: (int index) async {
                if(index == 1){
                  await showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
                    items: <PopupMenuItem<String>>[
                      new PopupMenuItem<String>(
                                child: Row
                                (children: <Widget>[
                                  Icon(Icons.book),
                                  SizedBox(width:width*0.02),
                                  Text('Your Bookmarks'),
                                ],),),
                      new PopupMenuItem<String>(
                                child: Row
                                (children: <Widget>[
                                  Icon(Icons.card_membership),
                                  SizedBox(width:width*0.02),
                                  Text('Admit Card'),
                                ],),),
                                             new PopupMenuItem<String>(
                                child: Row
                                (children: <Widget>[
                                  Icon(Icons.check_box),
                                  SizedBox(width:width*0.02),
                                  Text('Result'),
                                ],),),                      new PopupMenuItem<String>(
                                child: Row
                                (children: <Widget>[
                                  Icon(Icons.question_answer),
                                  SizedBox(width:width*0.02),
                                  Text('Answer Key'),
                                ],),),
                                                      new PopupMenuItem<String>(
                                child: Row
                                (children: <Widget>[
                                  Icon(Icons.share),
                                  SizedBox(width:width*0.02),
                                  Text('Share'),
                                ],),),
                                                     
                    ],
                    elevation: 8.0,
                  );
                }
              },
            ),
      body: 
    SingleChildScrollView(
      child: 
    Column(
      children: <Widget>[
         ExamTitle(exam: currentexam,),
         ExamInfo(exam:currentexam ,),
         ImportantLinks(exam: currentexam,),

      ],
    ),
    ),
    );
             }
           }
        )
        );
  }
}

class ExamTitle extends StatelessWidget {
  AllExams exam;
  ExamTitle({this.exam});
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    return
     Container(
      //margin: EdgeInsets.only(top: height*0.1),
      //height: height*0.2,
     
     // color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            height: height*0.05,
            child: 
            Center(
              child:
          Text(exam.id??"UPSC CSE 2063",
          style: TextStyle(
            fontSize: 24,
            fontWeight:FontWeight.bold ,
          ),),
            ),
          ),
          Card(
            child:
            Container(
              height: height*0.2,
              child: SvgPicture.asset("assets/images/time.svg",fit:BoxFit.contain,),
            )
            
            
          )
          
        ],
      ),
      
    );
  }
}

class ExamInfo extends StatelessWidget {
  AllExams exam;
  ExamInfo({this.exam});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
   
    
   //for (var i = 0; i < list1.length; i++) {
     //vacancy[i] = exam.vacancydetail;
   //}
  // var list1 = list2;
     
    
    /*
    for (var i = 0; i < postlist.length; i++) {
           vacancy[i] = exam.vacancydetail['${postlist[i]}'] as Map;
          //vacancyattributekeys[i] = vacancy[i].keys.tolist();
          //vacancyattributevalues[i] =  vacancy[i].values.toList();
    }
    */
    //var list1 = exam.vacancydetail ;
   // var list2 = list1.keys.toList();
    //var list3 = list2.tolist();
   // var list3 = list1.values.toList();
    //var list4 = list3 as Map;
    //var list5 = list4.keys.toList();
    //var hello = vacancynamelist.tolist();
    //List<String> list1 = vacancynamelist;
    return Container(

      //color: Colors.green,
      child: Column(
        children: <Widget>[
          SizedBox(height: height*0.02,),
          Container(
            padding: EdgeInsets.only(left: width*0.05),
            width: width,
            //color: Colors.red,
            child:
            Column(
             crossAxisAlignment:CrossAxisAlignment.start ,
             children: <Widget>[
                 Text("Post Date : ${exam.postdate}",style: TextStyle(fontWeight: FontWeight.bold,
                 fontSize: 16),),
                 Text("Latest update : ${exam.latestupdate}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ],
            )
         
          ),
        SizedBox(height: height*0.02,),
        InfoCard(heading:"Brief Information" ,info:exam.briefinfo,),
        DateCard(heading:"Important Dates" ,info: exam.importantdates,),
        FeeCard(heading:"Application Fee" ,info:exam.applicationfee,),
        AgeCard(heading:"Age Limit" ,info:exam.agelimit,),
        QualificationCard(heading:"Qualification" ,info:exam.qualification,),
       
        VacancyCard(heading:"Vacancy Detail" ,info:exam.vacancydetail,),
       /*
        for (var i = 0; i < postnamelist.length; i++) {
          "${postnamelist[0]}\t\t\t\t${vacancy[0]}\n${postnamelist[1]}\t\t\t\t${vacancy[1]}\n"
        }
        */
       // "${postnamelist[0]}\t\t\t\t${vacancy[0]}\n${postnamelist[1]}\t\t\t\t${vacancy[1]}\n" 
       
       //"${vacancy[0]}",),
       
        ],
      ),
      
    );
  }
}

class QualificationCard extends StatelessWidget {
  var info;
  String heading;
  QualificationCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            width: width,
            child:
            Card(
              
              child:
              Container(
               // height: height*0.1,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child:Text("${this.info}" 
              //"
              //DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription
              //"
              ,
              style: TextStyle(
              fontSize: 16,
            ),),
            ),
            )
            
          ),
        ],
      ),
      
    );
  }
}

class DateCard extends StatelessWidget {
  var info;
  String heading;
  DateCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    var datecategorylist = info.keys.toList();
    var date = info.values.toList();
    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            width: width,
            child:
            Card(
              
              child:
              Container(
               // height: height*0.1,
              alignment: Alignment.topLeft, 
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < datecategorylist.length; i++)
                    Container(
                      margin:EdgeInsets.only(top:height*0.005),
                      //padding: EdgeInsets.symmetric(horizontal: width*0.08,),
                      width: width,
                      color: Colors.grey[50],
                      child:Row(
                        children: <Widget>[
                          Container(
                            //color: Colors.yellow,
                            width: width*0.58,
                            child: Text("${datecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                          //Text("${agecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          SizedBox(width: width*0.02,child: Text(":"),),
                          Container(
                            //color: Colors.green,
                            width: width*0.25,
                            child: Text("${date[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                        ] ,
                      ),
                      
                    ),
                    
                ],
              ),
            ),
            )
            
          ),
        ],
      ),
      
    );
  }
}

class FeeCard extends StatelessWidget {
  var info;
  String heading;
  FeeCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    var feecategorylist = info.keys.toList();
   var fee = info.values.toList();
    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            width: width,
            child:
            Card(
              child:
              Container(
               // height: height*0.1,
              alignment: Alignment.topLeft, 
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < feecategorylist.length; i++)
                    Container(
                      margin:EdgeInsets.only(top:height*0.005),
                      padding: EdgeInsets.symmetric(horizontal: width*0.08,),
                      width: width,
                      color: Colors.grey[50],
                      child:Row(
                        children: <Widget>[
                          Container(
                            //color: Colors.yellow,
                            width: width*0.4,
                            child: Text("${feecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                          //Text("${agecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          SizedBox(width: width*0.02,child: Text(":"),),
                          Container(
                            //color: Colors.green,
                            width: width*0.3,
                            child: Text("${fee[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                        ] ,
                      ),
                      
                    ),
                    
                ],
              ),
            ),
            )
            
          ),
        ],
      ),
      
    );
  }
}

class AgeCard extends StatelessWidget {
  var info;
  String heading;
  AgeCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
/*
    for (var item in info){
      if (info[item]=='') {
         info.pop(item);
    }
    }
*/
    // List<int> age = List<int>(); 
    List<Widget> wlist  = List<Widget>();
   //var list0 = exam.vacancydetail;
   var agecategorylist = info.keys.toList();
   var age = info.values.toList();
  // for (var item in agecategorylist) {
  //    age.add(info['$item']); 
      //wlist[i] = Text("${postnamelist[i]}\t\t\t\t${vacancy[i]}\n");    
  // }


    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),
          ),
          Container(
            width: width,
            child:
            Card(
              
              child:
              Container(
               // height: height*0.1,
              alignment: Alignment.topLeft, 
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < agecategorylist.length; i++)
                    Container(
                      margin:EdgeInsets.only(top:height*0.005),
                      padding: EdgeInsets.symmetric(horizontal: width*0.08,),
                      width: width,
                      color: Colors.grey[50],
                      child:Row(
                        children: <Widget>[
                          Container(
                            //color: Colors.yellow,
                            width: width*0.4,
                            child: Text("${agecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                          //Text("${agecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          SizedBox(width: width*0.02,child: Text(":"),),
                          Container(
                            //color: Colors.green,
                            width: width*0.3,
                            child: Text("${age[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                        ] ,
                      ),
                      
                    ),
                    
                ],
              ),
            ),
            )
            
          ),
        ],
      ),
      
    );
  }
}
class InfoCard extends StatelessWidget {
  String examtitle;
  String heading;
  var info;
  InfoCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
            final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            width: width,
            child:
            Card(
              
              child:
              Container(
               // height: height*0.1,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child:Text("$info" 
              //"
              //DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription
              //"
              ,
              style: TextStyle(
              fontSize: 16,
            ),),
            ),
            )
            
          ),
        ],
      ),
      
    );
  }
}

class VacancyCard extends StatelessWidget {
  String heading;
  var info;
  VacancyCard({this.heading,this.info});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    //----------------------------------------------------------------
      List<dynamic> vacancykeys = List<dynamic>();
      List<dynamic> vacancyvalues = List<dynamic>();
      var postlistvalues = info.values.toList();
      
      
      for (var i = 0; i < postlistvalues.length; i++) {
        vacancykeys.add( postlistvalues[i].keys.toList());
        //vacancyvalues[i] = postlistvalues[i].values.tolist();
      }
      
    //----------------------------------------------------------------
    return Container(
      child: Column(

        
        children: <Widget>[
          //1
          Container(
           child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),
          ),
          ),
          //2
         
          Container(
            height: height*0.2,
            child:
          ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              for (var j = 0; j < vacancykeys.length; j++) 
               //for (var k = 0; k < vacancykeys[j].length; k++)
            Card(
              child: Container( 

                padding: EdgeInsets.all(width*0.08),
                  child:
                

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var k = 0; k < vacancykeys[j].length; k++)
                    Container(
                      child: 
                      Row(
                        children: <Widget>[
                          SizedBox( width:width*0.7,
                          child:Text('${vacancykeys[j][k]}')
                          ),
                          SizedBox(width:width*0.02,
                          child: Text(':'),
                          ),
                          SizedBox(width:width*0.7,
                          child:Text('${vacancykeys[j][k]}')
                          ),
                        ],
                      ),
                      
                    ),
                    
                  ],
                )
                
              ),
            ),
          
        ],
      ),
          ),
          ],
          


          ),
    );   
  }
}

/*
class VacancyCard extends StatelessWidget {
  String examtitle;
  String heading;
  var info;
  VacancyCard({this.heading,this.info,});
  @override
  Widget build(BuildContext context) {
            final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    List<dynamic> vacancykeys = List<dynamic>();
    List<dynamic> vacancyvalues = List<dynamic>(); 
    List<Widget> wlist  = List<Widget>();
   //var list0 = exam.vacancydetail;
   var postnamelist = info.keys.toList();
   for (var item in postnamelist) {
      vacancykeys.add(info['$item'].keys.toList());
      vacancyvalues.add(info['$item'].values.toList()); 
      //wlist[i] = Text("${postnamelist[i]}\t\t\t\t${vacancy[i]}\n");    
   }
   
    return Container(
     // width: width,
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("${this.heading}",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            width: width,
            child:
            Card(
              
              child:
              Container(
               // height: height*0.1,
              alignment: Alignment.topLeft, 
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < postnamelist.length; i++)
                    Container(
                      margin:EdgeInsets.only(top:height*0.005),
                      padding: EdgeInsets.symmetric(horizontal: width*0.08,),
                      width: width,
                      color: Colors.grey[50],
                      child:Row(
                        children: <Widget>[
                          Container(
                            //color: Colors.yellow,
                            width: width*0.4,
                            child: Text("${vacancykeys[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                          //Text("${agecategorylist[i]}",style: TextStyle(fontSize: 16,),),
                          SizedBox(width: width*0.02,child: Text(":"),),
                          Container(
                            //color: Colors.green,
                            //width: width*0.4,
                            child: Text("${vacancyvalues[i]}",style: TextStyle(fontSize: 16,),),
                          ),
                        ] ,
                      ),
                      
                    ),
                    
                ],
              ),
            ),
              
              /*
              Column(
                children: <Widget>[
                  for (var i = 0; i < postnamelist.length; i++)
                    Text("${postnamelist[i]}\t\t\t\t${vacancy[i]}\n")
                    
                ],
              ),
              */
         /*
            SizedBox(
              height: height*0.26,
              child:
               
             // Container(
             //   color:Colors.red,
               // height: height*0.3,
             // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
             // child:
              
             

              
              ListView.builder(
                primary: false,
                itemCount: postnamelist.length,
                itemBuilder: (BuildContext ctxt, int index) => 

                  Text("${postnamelist[index]}\t\t\t\t${vacancy[index]}\n"), 
              
              )
              
              
                /*
                Container(
                  color:Colors.yellow,
                  height: height*0.02,
                  child: Text("${postnamelist[index]}\t\t\t\t${vacancy[index]}\n"),
                )
                */
                
                
                
              /*
              Text("${this.description}" 
              //"
              //DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription
              //"
              ,
              style: TextStyle(
              fontSize: 16,
            ),),
            */
            //),
            ),
*/
            ),
            
          ),
        ],
      ),
      
    );
  }
}
*/


class ImportantLinks extends StatelessWidget {
  AllExams exam;
  ImportantLinks({this.exam});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
           // width: width,
            child: Text("Important Links",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold,
            ),),

          ),
          Container(
            //width: width,
            child:
            Card(
              child:
              Container(
                width: width,
                child: 
              Column(
                children: <Widget>[
                  FlatButton(onPressed:()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewScreen(
              title: " Apply Online ",
              selectedUrl: exam.applyonlinelink,//"https://alligator.io",
            ))), child: Text(" Apply Online ",style: TextStyle(
              fontSize: 16,
            ),),),
                  FlatButton(onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewScreen(
              title: " Notice ",
              selectedUrl: exam.noticelink,//"https://unsplash.com/s/photos/free",
            ))), child: Text(" Notice ",style: TextStyle(
              fontSize: 16,
            ),),),
                  FlatButton(onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewScreen(
              title: " Syllabus ",
              selectedUrl: exam.syllabuslink,//"https://alligator.io",
            ))), child: Text(" Syllabus ",style: TextStyle(
              fontSize: 16,
            ),),),
                  FlatButton(onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewScreen(
              title: " Official Website ",
              selectedUrl: exam.officialwebsitelink,//"https://alligator.io",
            ))), child: Text(" Official Website ",style: TextStyle(
              fontSize: 16,
            ),),),
                  
                  
                ],
              ),
              
              )
              
            )
            
          ),
        ],
      ),
      
    );
  }
}

Future<void> _shareText() async {
    try {
      Share.text('my text title',
          'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }