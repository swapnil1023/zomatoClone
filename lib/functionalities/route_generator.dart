import 'package:flutter/material.dart';
import 'package:my_flutter_app/ui/google_signin.dart';
import 'package:my_flutter_app/ui/loading.dart';
import 'package:my_flutter_app/ui/main_screen.dart';
import 'package:my_flutter_app/ui/homescreen.dart';
import 'package:my_flutter_app/ui/description.dart';
import 'package:my_flutter_app/ui/navigation.dart';
import 'package:my_flutter_app/ui/login_email.dart';
import 'package:my_flutter_app/ui/signUp_email.dart';
import 'package:my_flutter_app/ui/login_screen.dart';
import 'package:my_flutter_app/ui/imageViewer.dart';
import 'package:my_flutter_app/ui/cart.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/main_screen':
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case '/imageViewer':
        return MaterialPageRoute(
          builder: (_) => ImageViewer(args),
        );
      case '/description':
        return MaterialPageRoute(
          builder: (_) => Description(),
        );
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/login_screen':
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case '/google_signin':
        return MaterialPageRoute(
          builder: (_) => GoogleSignIn(),
        );
      case '/login_email':
        return MaterialPageRoute(
          builder: (_) => LoginEmail(),
        );
      case '/signUp_email':
        return MaterialPageRoute(
          builder: (_) => SignUP(),
        );
      case '/loading':
        return MaterialPageRoute(
          builder: (_) => Loading(),
        );
      case '/navigation':
        return MaterialPageRoute(
          builder: (_) => Navigation(),
        );
        case '/cart':
        return MaterialPageRoute(
          builder: (_) => Cart(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<void> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      //SystemNavigator.pop();
      return Scaffold(
        appBar: AppBar(
          title: Text('/'),
        ),
        body: Center(
          child: Text('/'),
        ),
      );
    });
  }
}