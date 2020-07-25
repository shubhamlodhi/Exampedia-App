import 'package:exampedia_app/pages/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
//import 'package:qtlearn/screens/screens.dart';

//import 'package:qtlearn/values/values.dart';
//import 'package:country_code_picker/country_code_picker.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreenWidget extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  String phoneNo;
  String smsCode;
  String verificationId;
  String status;
  FirebaseUser currentUser;
  Future<void> verifyPhone(BuildContext context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
      print("retrive");
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('OTP SENT');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      print('verified');

      //_authCredential = auth;

      FirebaseAuth.instance.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          print('Authentication successful');
          //signIn();
        } else {
          print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        print('Something has gone wrong, please try later');
      });
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);

    assert(await user.getIdToken() != null);

    currentUser = await FirebaseAuth.instance.currentUser();

    assert(user.uid == currentUser.uid);

    print(user.displayName);
    print(user.email);

    print('signInWithGoogle succeeded: $user');
  }
//===============================================================

  Future<bool> smsCodeDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                // color: Colors.red,
                //borderRadius: BorderRadius.all(Radius.circular(80)),
                ),
            height: 350,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Verify Mobile Number",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Enter the OTP sent to $phoneNo",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            this.smsCode = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter OTP *",
                          ),
                        ),
                      ),
                      //Container(child: RaisedButton(onPressed: (){signIn();}),),
                      Container(
                        height: 40,
                        padding: EdgeInsets.only(top: 10),
                        //margin: EdgeInsets.only(right: 95, bottom: 36),
                        child: Text(
                          "Resend OTP",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.pink[200],
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        width: 138,
                        height: 39,
                        padding: EdgeInsets.only(left: 200),
                        child: FlatButton(
                          onPressed: () => signIn(),
                          color: Colors.blue,
                         // AppColors.primaryBackground,
                          //Color(0xFFD8D8D8),
                          shape: RoundedRectangleBorder(
                          //  borderRadius: Radii.k8pxRadius,
                          ),
                          textColor: Color(0xFFD8D8D8),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

//=============================================================================================
  void signOutGoogle() async {
    await GoogleSignIn().signOut();

    print("User Sign Out");
  }

  signIn() {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      //Navigator.of(context).pushReplacementNamed(LoginScreenWidget.tag);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }).catchError((e) {
      print(e);
    });
  }

  void onButtonPressed(BuildContext context) => verifyPhone;

  onGoogleSignPressed(BuildContext context) =>
      signInWithGoogle().whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(),
          ),
        );
      });
//---------------

  /// Besides the user entering their phone number, we also need to know the user's country code
  /// for that we are gonna use a library CountryCodePicker.
  /// The method takes in an [error] message from our validator.

  Widget _phoneInputField(String error) {
    return Container(
      height: 45,
      width: 300,
      decoration: BoxDecoration(

      //  borderRadius: Radii.k8pxRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: CountryCodePicker(
                onChanged: print,
                initialSelection: 'IN',
                favorite: ['+91', 'IN'],
                showCountryOnly: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                countryFilter: ['US', 'IN'],
              ),
            ),
          ),
          */
          
          Expanded(
            //flex: 2,
            child: 
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),

              // color: Colors.transparent,
              child: 
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w500,
                  //color: AppColors.primaryText,
                ),
                onChanged: (value) {
                  this.phoneNo = "+91" + value;
                  verifyPhone(context);
                },
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  //fillColor: Colors.white,
                  //contentPadding: EdgeInsets.symmetric(horizontal: 80),

                  enabledBorder: OutlineInputBorder(
                    //borderRadius: Radii.k8pxRadius,
                    borderSide: BorderSide(color: Colors.white),
                  ),

                  focusedBorder: OutlineInputBorder(
                   // borderRadius: Radii.k8pxRadius,
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          
          //2
          Container(
            height: 45,
            width: 1,
            color: Colors.black,
          ),
          //3

          FlatButton(
            //elevation: 10,
            shape: RoundedRectangleBorder(
             // borderRadius: Radii.k8pxRadius,
            ),
            color: Colors.white,
            splashColor: Colors.yellow,
            onPressed: () {
              signIn();
            },
            child: Container(
              height: 45,
              width: 60,
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
              child: Text(
                " VERIFY ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0066FF),
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // ),

          // ),
          // ),
        ],
      ),
    );
  }

//
Widget _or()
{
  final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
  return
    
  Container(
   // color: Colors.transparent,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //color : Colors.red,
            child: Center(child:
            Container(
                height: 1,
                width: 110,
                color: Colors.black,
              ),
            ),
          ),
          
          Container(
           // color : Colors.transparent,
                width: width*0.1666,
                child: Center(
                  child: Text(
                    "Or",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: AppColors.primaryText,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                //color : Colors.transparent,
            child: Center(child:
            Container(
                height: 1,
                width: 110,
                color: Colors.black,
              ),
            ),
          ),
          

        ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print('width is $width; height is $height');
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/login.jpg"), // <-- BACKGROUND IMAGE
                fit: BoxFit.cover,
              ),
            ),
          ),
         // ListView(children: <Widget>[

      /*  
          //Phone Input Component
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      //color: Colors.green,
                      //height: 100,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      padding: EdgeInsets.only(
                        top: height * 0.55,
                      ),
                      child: Card(
                        child: _phoneInputField(""),
                      )),
                ),

                
 
//Consume Image
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: 10),

                    padding: EdgeInsets.only(top: height * 0.40),

                    // margin: EdgeInsets.only(top: 78),
                    child: Image.asset(
                      "assets/images/consume-tag.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
//Or
         Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      //color: Colors.green,
                      //height: 100,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.11),
                      padding: EdgeInsets.only(
                        top: height * 0.33,
                      ),
                      child: Container(
                        //color: Colors.transparent.withOpacity(0),
                        child: _or(),
                      )),
                ),
*/
//Google Sign In Button
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                //color: Colors.yellow,
                padding: EdgeInsets.only(top: height * 0.7),
                child: GoogleSignInButton(
                  onPressed: () => this.onGoogleSignPressed(context),
                  darkMode: false, // default: false
                )),
          ),
// bottom Logo

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              //margin:EdgeInsets.only(bottom:20),
              padding: EdgeInsets.only(
                top: height * 0.85,
              ),
              child: Image.asset(
                "assets/images/qt-learn-2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
     //     ],),
        ],
      ),
    );
    
  }
}
