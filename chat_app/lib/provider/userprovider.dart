import 'package:chatapp/database/users.dart';
import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{

  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

  FirebaseAuth _auth;
  FirebaseUser _user;

  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  UserServices _userServices = UserServices();

  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future signOut() async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> signIn(AuthCredential authCreds) async{
    try {
      await _auth.signInWithCredential(authCreds);
      _status = Status.Authenticated;
      notifyListeners();

      MaterialPageRoute(builder: (context)=>HomeScreen());
    }
    catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
    }
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  Future<bool> signUp(String name, String email, String phoneNo) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();

      Map<String, dynamic> values = {
        "name": name,
        "email": email,
        "phoneNo": phoneNo
      };
      _userServices.createUser(values);
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }
    else{
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }


  Future<void> verifyPhone(phoneNo) async {

    //this.phoneNo = '+91' + phoneNo;
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
        this.codeSent = true;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(minutes: 1),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}