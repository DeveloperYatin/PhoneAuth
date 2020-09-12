import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phoneauth/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';




class GoogleLoginScreen extends StatelessWidget {
  bool _isLoggedIn = false;

  final FirebaseUser user;

  GoogleLoginScreen({this.user});

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login(String phone, BuildContext context) async{
    try{
      await _googleSignIn.signIn();
        _isLoggedIn = true;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen(user: user,)
        ));
      
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
      _isLoggedIn = false;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
                      Text(_googleSignIn.currentUser.displayName),
                      OutlineButton( child: Text("Logout"), onPressed: (){
                        _logout();
                      },)
                    ],
                  )
                : Center(
                    child: OutlineButton(
                      child: Text("Login with Google"),
                      onPressed: () {
                        _login(user.phoneNumber,context); //Can be used to send gmail varification name,image url, email as well
                      },
                    ),
                  )),
      ),
    );
  }
}