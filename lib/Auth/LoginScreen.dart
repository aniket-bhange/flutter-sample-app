
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _password;
  String _email;

  TextStyle textStyle = TextStyle( fontFamily: 'Montserrat', fontSize: 20.0 );

  TextStyle brandNameStyle = TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 28.0);

  var inputDecoration = (String hint)=> InputDecoration(contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0), hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        obscureText: false,
        style: textStyle,
        decoration: inputDecoration('you@example.com'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if(value.isEmpty){
            return 'Email is required';
          }
          if(!isEmail(value)){
            return "The E-mail Address must be a valid email address.";
          }
          return null;
        },
        onSaved: (value){
          _email = value.trim();
        },
      )
    );

    final passwordField = Container(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        obscureText: true,
        style: textStyle,
        decoration: inputDecoration('Password'),
        validator: ( value ){
          if(value.isEmpty){
            return 'Password is required';
          }
          if (value.length < 5) {
            return 'The Password must be at least 8 characters.';
          }
          return null;
        },
        onSaved: (value){
          _password = value.trim();
        },
      ),
    );

    final pageButton = (String text, Color color,Function eventFunc)=> Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      
      // color: Color(0xFF7A9BEE),
      color: color,
      child: MaterialButton(
        onPressed: eventFunc,
        minWidth: MediaQuery.of(context).size.width - 50,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(text, style: textStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
      ),
    );


    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: SingleChildScrollView(
        
        child: Builder(
          builder: (context){
            return Column(
              children: <Widget>[
                SizedBox(height: 80.0,),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Row(
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4.0,
                              color: Colors.white
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            color: Color(0xFF7A9BEE)
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.utensils,
                              color: Colors.white,
                              size: 38.0,
                            ),
                          ) 
                          
                        ),
                        
                        SizedBox(width: 20.0,),
                        Row(
                          children: <Widget>[
                            Text('Healthy', style: this.brandNameStyle.copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10.0,),
                            Text('Food', style: this.brandNameStyle,),
                          ],
                        ),
                      ],
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0))
                  ),
                  height: MediaQuery.of(context).size.height - 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: <Widget>[
                        emailField,
                        SizedBox(height: 25.0),
                        passwordField,
                        SizedBox(
                          height: 35.0,
                        ),
                        pageButton('LOGIN', Color(0xFF7A9BEE), (){
                          _submitForm(context);
                        }),
                        SizedBox(
                          height: 15.0,
                        ),
                        pageButton('NEW USER', Color(0xFF21BFBD), (){
                          Navigator.pushNamed(context, '/register');
                        }),
                      ],
                    )
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _submitForm(_self) async {
    if(_loginFormKey.currentState.validate()){

      try{
        this._loginFormKey.currentState.save();
        AuthResult authResult = (await this._auth.signInWithEmailAndPassword(email: _email, password: _password));
        final tokenInst = (await authResult.user.getIdToken());
        final prefs = await SharedPreferences.getInstance();
        // print(tokenInst.token);
        prefs.setString('usertoken', jsonEncode(<String, String>{
          'email': authResult.user.email,
          'name': authResult.user.displayName,
          'token': tokenInst.token,
        }));
        Navigator.of(context).pushNamed('/home');
      }catch(err){
        print(err);
        Scaffold.of(_self).showSnackBar(SnackBar(content: Text("Wrong Email or Password")));
      }
    }
  }

  bool isEmail(String email){
    String exp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(exp);
    return regExp.hasMatch(email);

  }
}