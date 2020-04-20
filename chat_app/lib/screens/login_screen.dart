import 'package:chatapp/provider/userprovider.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:chatapp/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _otp = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  final _Key = GlobalKey<ScaffoldState>();

//  String phoneNo, verificationId, smsCode;
//  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _Key,
      body: user.status == Status.Authenticating ? Splash() : Stack(
        children: <Widget>[
          Container(
            color: Colors.white70.withOpacity(0.7),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 80, bottom: 95, left: 20, right: 20),
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
                        Center(
                            child: Text(
                          "LogIn Screen:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue.withOpacity(0.25),
                              elevation: 0.1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _phone,
                                  decoration: InputDecoration(
                                      hintText: "Phone Number: ",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.black45,
                                      ),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    setState(() {
                                      user.phoneNo = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Enter your Phone Number!!!";
                                    }
                                    return null;
                                    // ignore: missing_return
                                  },
                                ),
                              )),
                        ),
                        user.codeSent
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.blue.withOpacity(0.25),
                                    elevation: 0.1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: TextFormField(
                                        controller: _otp,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintText: "Enter OTP Number: ",
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                            icon: Icon(
                                              Icons.accessibility,
                                              color: Colors.black45,
                                            ),
                                            border: InputBorder.none),
                                        onChanged: (value) {
                                          setState(() {
                                            user.smsCode = value;
                                          });
                                        },
                                      ),
                                    )),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blueGrey,
                            elevation: 0.1,
                            child: MaterialButton(
                              onPressed: () {
                                if(_formKey.currentState.validate()){
                                  user.codeSent ? user.signInWithOTP(user.smsCode, user.verificationId) : user.verifyPhone(user.phoneNo);
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Center(
                                child: user.codeSent
                                    ? Text(
                                        "Sign In",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    : Text(
                                        "Verify",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
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
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Create an account?",
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
