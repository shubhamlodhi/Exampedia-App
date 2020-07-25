import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampedia_app/pages/loading.dart';
import 'package:exampedia_app/services/models.dart';
import 'package:exampedia_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'examdetailscreen.dart';
import 'examlistscreen.dart';

/*
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
*/

class HomeScreen extends StatefulWidget {
  static String tag = 'Home-page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
/*
var lbpathRef = "q";
    print("pathref:  " + lbpathRef);
final Collection<Upcomingexam> lbuserRef =
          Collection(path: lbpathRef);
      print("Project path is :" + lbpathRef);
      */

                
    return 
     WillPopScope( 
         onWillPop: ()=>
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
      
      )))
         ,child:
    Scaffold(
      drawer: Drawer(

      ),
      appBar: AppBar(title: Text("Exampedia India")
      ),
      body: 
    SingleChildScrollView(
      child: Column(
        
      
      children: <Widget>[
        Container(
            //height: height*0.4,
           // color: Colors.orange,
            child:CarouselChangeReasonDemo(),
          ),
//StateList
          Statelist(),
/*
          Container(
            height: height*0.15,
            //color: Colors.red,
            child: 
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
              ],
            )
            
          ),
*/

        Container( // Upcoming Exam Container
      //color: Colors.blue,
      child: Column(
        children: <Widget>[

          //heading--------
          Container(
            width: width,
            margin: EdgeInsets.only(left:5),
            //color: Colors.red,
            child: 
             Text('Upcoming Exams',
             textAlign: TextAlign.left,
             style: TextStyle(
             fontSize: 25,
          ),)
          ),
          //List of cards
            Upcomingexamlist(),
          /*
          Container(
            child: Column(
              children: examinfo.map((examInfo) => SmallExamCard(
                examname: examInfo.id,
                qualification: examInfo.qualification??"NA",
                lastdate: examInfo.lastdate??"NA",
              )).toList()),
            ),
          */
          
          /*
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          SmallExamCard(),
          */

         
        ],
      ),
          ),
        Container(
          height:height*0.3,
     // color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            child: 
            Row(
              children: <Widget>[
                Container(
                  width: width*0.5,
                  height: height*0.2,
                  child: Text(
            "Your Guide For Exams",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 40, 
            ),
            ),
                ),
                Container(
                  width: width*0.5,
                  height: height*0.2,
                  child: SvgPicture.asset('assets/images/time.svg'),
                ),
            ],)    
          ),
          SizedBox(height: height*0.05),
          Container(
            child: Column(
              children: <Widget>[
                Text("Made by Zoraki Pvt. Ltd."),
               // Text(""),
              ],
            )
          )
        ],
      ),
          ),
      ],
      ),
    ),
    ),
     );
      
          
      
  }
}



//Components

//Small Exam Card
class SmallExamCard extends StatelessWidget {
  String examname;
  String qualification;
  String lastdate;
  String region;
  SmallExamCard({this.examname,this.lastdate,this.qualification,this.region});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return 
    FlatButton(
     onPressed:(){
     Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExamdetailScreen(
                    examtitle: examname,
                    region:region,
                  )));
     },
     child: 
    Container(
                 // height:100 ,
                  child: Card(
                    child:
                    Row(
                      children: <Widget>[
                         //Card(
                           //child: 
                        Container(
                          padding: EdgeInsets.all(10),
                          height: height*0.12,
                          width: width*0.2,
                          child: Image.asset('assets/images/file.png',
                  width: 20,
                  fit: BoxFit.fill,),
                        ),
                        //),
                        SizedBox(width: width*0.02,),
                        Container(
                         // color: Colors.blue,
                          child:
                          Column(
                            children: <Widget>[
                              Container(
                                //color: Colors.green,
                                width: width*0.6,
                                child:
                                Text(examname,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                              SizedBox(height: height*0.02,),
                              Container(
                                width: width*0.6,
                                //color: Colors.green,
                                child:
                                Text(qualification,
                                style: TextStyle(
                                  fontSize: 18,
                                  //fontWeight: FontWeight.bold
                                ),),
                              ),
                              Container(
                                width: width*0.6,
                                //color: Colors.red,
                                child:
                                Text(lastdate,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,

                                  //fontWeight: FontWeight.bold
                                ),),
                              ),
                            ],
                          ),
                          
                          
                        ),

                          
                      ],
                    )
                                       
                ),
      
    ),
    );
  }
}

//State Card

class StateCard extends StatelessWidget {
  String stateimage;
  String statename;
  StateCard({this.stateimage,this.statename});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return 
    FlatButton(
      onPressed:(){
     Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExamlistScreen(region:statename)));
     },
     child:
      
    Container(
   // height: height*0.01,
      width: width*0.3,
      child:
      Card(
        child: 
         Stack(
            children: <Widget>[
               Container(
                 //color: Colors.blue,
                 child:
                 Center(
                   child:SvgPicture.asset('assets/images/time.svg',fit: BoxFit.fitWidth,) ,
                 ) 
               ),
              Align(
                alignment: Alignment.center,
                child:
                Card(
                  color: Colors.transparent.withOpacity(0.5),
                  child:
                Container(
                  padding: EdgeInsets.all(width*0.05),
                  //width: width*0.4,
                //height: 100,
                //color: Colors.transparent.withOpacity(0.5),
                child: 
                Center(
                  child:Text(statename
                  ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),) ,
                )
                ) ,
                ),
              )
              
             
                
              //child:Text('data',textAlign: TextAlign.center,),
            ],
          )
           
        ),
    )
    )
    ;
  }
}

class MainCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      height: height*0.05,
      child:
      Card(
        child: 
        Container(
          child: Image.asset('assets/images/file.png'),
        ),
      )
      ,
    );
  }
}

class CarouselChangeReasonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselChangeReasonDemoState();
  }
}

class _CarouselChangeReasonDemoState extends State<CarouselChangeReasonDemo> {
  String reason = '';
  final CarouselController _controller = CarouselController();

  onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return MultiProvider(
       providers: [
         StreamProvider<FirebaseUser>.value(value: AuthService().user)
        ],
        child: FutureBuilder(
            future: Global.upcomingExamRef.getData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              var user = Provider.of<FirebaseUser>(context);
             
              print(user.toString());
              if (!snap.hasData) {
                print("User Screen snap no data ");
                return LoadingScreen();
              } else {
                print("Users Screen snap" + snap.data.toString());
                List<Upcomingexam> advImagesinfo = snap.data;
    return 

    //Scaffold(
      
     // body: SingleChildScrollView(
       // child: Column(
         // children: <Widget>[
           Container(
           // width: width,
            //height: height*0.2,
             child: 
            CarouselSlider(
              items: advImagesinfo.map((item) =>
              Container(
  
  child: Container(
   
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(

      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                fit: BoxFit.cover,),
         //Image.asset('assets/images/file.png'),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0
              ),
              child: Text(
               item.id
               // 'Adv.No. ${advImagesinfo.indexOf(item)} image',
                ,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  ),
)).toList()

              //imageSliders,
              ,
              options: CarouselOptions(
                //height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                aspectRatio: 10/6.5,
                onPageChanged: onPageChange,
                autoPlay: true,
              ),
          
              carouselController: _controller,
            ),
           );
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.previousPage(),
                    child: Text('←'),
                  ),
                ),
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.nextPage(),
                    child: Text('→'),
                  ),
                ),
                ...Iterable<int>.generate(imgList.length).map(
                  (int pageIndex) => Flexible(
                    child: RaisedButton(
                      onPressed: () => _controller.animateToPage(pageIndex),
                      child: Text("$pageIndex"),
                    ),
                  ),
                ),
              ],
            ),
            
            Center(
              child: Column(children: [
                Text('page change reason: '),
                Text(reason),
              ],),
              */
           // )
         // ],
       // ),
     // )
    //);
             }
           }
        )
        );
  }
}

/*
final List<Widget> imageSliders = imgList.map((item) => Container(
  
  child: Container(
   
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(

      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network(item, fit: BoxFit.cover,),
         //Image.asset('assets/images/file.png'),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0
              ),
              child: Text(
                'No. ${imgList.indexOf(item)} image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  ),
)).toList();
*/






class Upcomingexamlist extends StatefulWidget {
  @override
  _UpcomingexamlistState createState() => _UpcomingexamlistState();
}

class _UpcomingexamlistState extends State<Upcomingexamlist> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
         StreamProvider<FirebaseUser>.value(value: AuthService().user)
        ],
        child: FutureBuilder(
            future: Global.upcomingExamRef.getData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              var user = Provider.of<FirebaseUser>(context);
             
              print(user.toString());
              if (!snap.hasData) {
                print("User Screen snap no data ");
                return LoadingScreen();
              } else {
                print("Users Screen snap" + snap.data.toString());
                List<Upcomingexam> examinfo = snap.data;


                return 
                Container(
            child: Column(
              children: examinfo.map((examInfo) => SmallExamCard(
                examname: examInfo.id,
                region: examInfo.region,
                qualification: examInfo.qualification??"NA",
                lastdate: examInfo.lastdate??"NA",
              )).toList()),
            );
                   }
           }
        )
        );
  }
}


class Statelist extends StatefulWidget {
  @override
  _StatelistState createState() => _StatelistState();
}

class _StatelistState extends State<Statelist> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return MultiProvider(
       providers: [
         StreamProvider<FirebaseUser>.value(value: AuthService().user)
        ],
        child: FutureBuilder(
            future: Global.stateExamRef.getData(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              var user = Provider.of<FirebaseUser>(context);
             
              print(user.toString());
              if (!snap.hasData) {
                print("User Screen snap no data ");
                return LoadingScreen();
              } else {
                print("Users Screen snap" + snap.data.toString());
                List<Stateexam> stateinfo = snap.data;
/*
Container(
            height: height*0.15,
            //color: Colors.red,
            child: 
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
                StateCard(),
              ],
            )
            
          ),
*/
                return 
                Container(
                  height: height*0.15,
            child: 
            ListView(
              scrollDirection: Axis.horizontal, 
              children: stateinfo.map((stateInfo) => StateCard(
                stateimage: 'a'//stateInfo.image
                ??"NA",
                statename: stateInfo.id//stateInfo.name
                ??"NA",
              )).toList()),
            );
                   }
           }
        )
        );
  }
}



