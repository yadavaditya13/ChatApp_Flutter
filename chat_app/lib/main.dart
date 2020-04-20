import 'package:chatapp/provider/userprovider.dart';
import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: UserProvider.initialize())],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenController(),
      )
    )
  );
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    switch(user.status){
      case Status.Uninitialized:
        return LogIn();
      case Status.Authenticated:
        return HomeScreen();
      case Status.Authenticating:
      case Status.Unauthenticated:
        return LogInScreen();
      default:
        return LogIn();

    }
  }
}
