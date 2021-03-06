import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_app/blocs/userBloc.dart';
import 'package:my_flutter_app/functionalities/auth.dart';
import 'package:my_flutter_app/functionalities/sql_service.dart';
import 'package:my_flutter_app/models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'myApp.dart';

class DrawerWidget extends StatefulWidget {
  final BuildContext navContext;
  DrawerWidget({this.navContext});
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  AuthService auth = new AuthService();
  String userEmail;
  String userId;
  User userProvider;


  Future<void> _logout(context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(
              'Logout ?',
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    //Navigator.of(context).pop();
                    await auth.logout(widget.navContext);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('Yes',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.deepPurple[900]))),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No',
                      style: TextStyle(fontSize: 18.0, color: Colors.pink)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<String> locationList = Provider.of<List<String>>(context);
    userProvider = Provider.of<User>(context);
    userEmail = userProvider.name;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: InkWell(
              onTap: () {
                Navigator.of(widget.navContext).pushNamed('/profile',arguments: context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      userEmail == null ? '' : userEmail,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.pink, Colors.deepPurple])),
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Home'),
          //   onTap: () {
          //     Navigator.of(widget.navContext).pushNamedAndRemoveUntil(
          //                 '/navigation', (Route<dynamic> route) => false);
          //   },
          // ),
          ListTile(
            leading: Hero(tag: 'wishlist', child: Icon(Icons.favorite)),
            title: Text('Wishlist'),
            onTap: () {
              Navigator.of(widget.navContext)
                  .pushNamed('/wishlist', arguments: context);
            },
          ),
          /* ListTile(
                leading: Icon(Icons.history),
                title: Text('Order History'),
                onTap: () {},
              ), */
          ListTile(
            leading: Hero(tag: 'feedback', child: Icon(Icons.feedback)),
            title: Text('Feedback'),
            onTap: () {
              Navigator.of(widget.navContext)
                  .pushNamed('/feedback', arguments: widget.navContext);
            },
          ),
          ListTile(
            leading: Icon(Icons.backspace),
            title: Text('Logout'),
            onTap: () {
              _logout(context);
            },
          ),
          ListTile(
            leading: Hero(tag: 'about', child: Icon(Icons.info)),
            title: Text('About'),
            onTap: () {
              Navigator.of(widget.navContext).pushNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
