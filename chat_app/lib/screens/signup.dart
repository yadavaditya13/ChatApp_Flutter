import 'package:chatapp/database/users.dart';
import 'package:chatapp/provider/userprovider.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _name = TextEditingController();
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white70.withOpacity(0.7),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 44, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 30.0)
                    ]),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              "images/logo.jpg",
                              width: 250.0,
                              height: 200.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue.withOpacity(0.25),
                              elevation: 0.1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: TextFormField(
                                  controller: _name,
                                  decoration: InputDecoration(
                                      hintText: "Full Name: ",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      icon: Icon(
                                        Icons.person_outline,
                                        color: Colors.black45,
                                      ),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Don't be Lazy... Enter your Name!!!";
                                    }
                                    return null;
                                    // ignore: missing_return
                                  },
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue.withOpacity(0.25),
                              elevation: 0.1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                      hintText: "E-Mail: ",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.black45,
                                      ),
                                      border: InputBorder.none),
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Enter a valid Email Address!!!';
                                      else
                                        return null;
                                      // ignore: missing_return
                                    }
                                  },
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue.withOpacity(0.25),
                              elevation: 0.1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: TextFormField(
                                  controller: _phone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: "Phone Number: ",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.black45,
                                      ),
                                      border: InputBorder.none),
                                  validator: (value) {
                                    Pattern pattern = r'^[0-9]';
                                    RegExp regex = new RegExp(pattern);
                                    if (value.isEmpty) {
                                      return "Enter your Phone Number!!!";
                                    } else if (value.trim().length != 10) {
                                      return "Enter 10 digits number...";
                                    } else if (!regex.hasMatch(value)) {
                                      return "Enter a valid 10 digits number...";
                                    }
                                    return null;
                                    // ignore: missing_return
                                  },
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blueGrey,
                            elevation: 0.1,
                            child: MaterialButton(
                              onPressed: () {
                                if(_formKey.currentState.validate()){
                                  user.signUp(_name.text, _email.text, _phone.text);
                                  //if(res == true){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInScreen()));
                                 // }
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            },
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.red),
                            ),
                          )),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
