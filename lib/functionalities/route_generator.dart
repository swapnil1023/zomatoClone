import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_app/ui/about.dart';
import 'package:my_flutter_app/ui/addDemand.dart';
import 'package:my_flutter_app/ui/forgot_password.dart';
import 'package:my_flutter_app/ui/loading.dart';
import 'package:my_flutter_app/ui/main_screen.dart';
import 'package:my_flutter_app/ui/homescreen.dart';
import 'package:my_flutter_app/ui/description.dart';
import 'package:my_flutter_app/ui/navigation.dart';
import 'package:my_flutter_app/ui/login_email.dart';
import 'package:my_flutter_app/ui/profile.dart';
import 'package:my_flutter_app/ui/review_cart.dart';
import 'package:my_flutter_app/ui/signUp_email.dart';
import 'package:my_flutter_app/ui/login_screen.dart';
import 'package:my_flutter_app/ui/discover.dart';
import 'package:my_flutter_app/ui/imageViewer.dart';
import 'package:my_flutter_app/ui/cart.dart';
import 'package:my_flutter_app/ui/share.dart';
import 'package:my_flutter_app/ui/discover1.dart';
import 'package:my_flutter_app/ui/wishlist.dart';
import 'package:my_flutter_app/ui/feedback.dart';
import 'package:my_flutter_app/ui/successScreen.dart';

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
          builder: (_) => ImageViewer(data: args),
        );
      case '/description':
        return MaterialPageRoute(
          builder: (_) => Description(args: args),
        );
      case '/discover':
        return MaterialPageRoute(
          builder: (_) => Discover(args: args),
        );
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/login_screen':
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case '/login_email':
        return MaterialPageRoute(
          builder: (_) => LoginEmail(),
        );
      case '/signUp_email':
        return MaterialPageRoute(
          builder: (_) => SignUP(),
        );
      case '/forgot_password':
        return MaterialPageRoute(
          builder: (_) => ForgotPass(),
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
          builder: (_) => Cart(providerContext: args),
        );
      case '/share':
        return MaterialPageRoute(
          builder: (_) => Share(),
        );
      case '/discover1':
        return MaterialPageRoute(
          builder: (_) => Discover1(),
        );
      case '/wishlist':
        return MaterialPageRoute(
          builder: (_) => Wishlist(
            providerContext: args,
          ),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => Profile(navContext: args),
        );
      case '/feedback':
        return MaterialPageRoute(
          builder: (_) => FeedbackPage(),
        );
      case '/review_order':
        return MaterialPageRoute(
          builder: (_) => ReviewCart(
            navContext: args,
          ),
        );
      case '/addDemand':
        return MaterialPageRoute(
          builder: (_) => AddDemand(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (_) => About(),
        );
      case '/successScreen':
        return MaterialPageRoute(
          builder: (_) => SuccessScreen(
            details: args,
          ),
        );
      // If args is not of the correct type, return an error page.
      default:
        return _errorRoute();
    }
  }

  static Route<void> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      //SystemNavigator.pop();
      return Scaffold(
        body: Center(
          child: SpinKitChasingDots(
            color: Colors.purple,
          ),
        ),
      );
    });
  }
}
