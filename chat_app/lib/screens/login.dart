import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  top: 80, bottom: 80, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 30.0)
                    ]),
                child: Form(
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
                    Divider(),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.lightBlue,
                        elevation: 0.1,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "LogIn",
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blueGrey,
                        elevation: 0.1,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
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
