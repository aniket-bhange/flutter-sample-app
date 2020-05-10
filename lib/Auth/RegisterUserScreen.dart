import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisteruserScreen extends StatefulWidget {
  RegisteruserScreen({Key key}) : super(key: key);

  @override
  _RegisteruserScreenState createState() => _RegisteruserScreenState();
}

class _RegisteruserScreenState extends State<RegisteruserScreen> {
  final _registerForm = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextStyle textStyle = TextStyle( fontFamily: 'Montserrat', fontSize: 20.0 );
  var inputDecoration = (String hint)=> InputDecoration(contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0), hintText: hint, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));

  String _name;
  String _email;
  String _password;


  @override
  Widget build(BuildContext context) {

    final nameField = Container(
      width: MediaQuery.of(context).size.width - 50.0,
      child: TextFormField(
        obscureText: false,
        style: textStyle,
        decoration: inputDecoration('Full Name*'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if(value.isEmpty){
            return 'Name is manditory';
          }
          return null;
        },
        onSaved: (value){
          setState(() {
            _name = value;
          });
        },
      )
    );

    final emailField = Container(
      width: MediaQuery.of(context).size.width - 50.0,
      child: TextFormField(
        obscureText: false,
        style: textStyle,
        decoration: inputDecoration('Email*'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if(value.isEmpty){
            return 'Email is manditory';
          }
          return null;
        },
        onSaved: (value){
          setState(() {
            _email = value;
          });
        },
      )
    );

    final passwordField = Container(
      width: MediaQuery.of(context).size.width - 50.0,
      child: TextFormField(
          obscureText: true,
          style: textStyle,
          decoration: inputDecoration('Password*'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if(value.isEmpty){
              return 'Password is manditory';
            }
            return null;
          },
          onSaved: (value){
            setState(() {
              _password = value;
            });
          },
        )
    );

    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      

      body:
      SingleChildScrollView(
        child: Builder(
          builder: (context){
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios), 
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 70.0,),
                      Text('New', style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),),
                      SizedBox(width: 10.0,),
                      Text('User', style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'Montserrat', fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 168.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0))
                  ),
                  child: Form(
                    key: _registerForm,
                    child: Container(
                      margin: EdgeInsets.only(top: 130.0),
                      // width: MediaQuery.of(context).size.width - 40.0,
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          nameField,
                          SizedBox(height: 20.0,),
                          emailField,
                          SizedBox(height: 20.0,),
                          passwordField,
                          SizedBox(height: 20.0,),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF7A9BEE),
                            child: MaterialButton(
                              onPressed: (){ saveUser(); },
                              minWidth: MediaQuery.of(context).size.width - 50.0,
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              child: Text('Create New User', style: textStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.center,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                    
              ],
            );
          },
        ),
      ) 
      
    );
  }

  saveUser() async {
    if(!_registerForm.currentState.validate()){
      return;
    }
    _registerForm.currentState.save();
    try{
      AuthResult authResult =  (await this._auth.createUserWithEmailAndPassword(email: _email, password: _password));
      final tokenInst = (await authResult.user.getIdToken());
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('usertoken', jsonEncode(<String, String>{
        'email': authResult.user.email,
        'name': authResult.user.displayName,
        'token': tokenInst.token,
      }));
      Navigator.pushNamed(context, '/home');
    }catch(err){
      print(err);
    }
    

  }
}