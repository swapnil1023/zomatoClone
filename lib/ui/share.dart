import 'package:flutter/material.dart';
import 'package:my_flutter_app/ui/drawerWidget.dart';

class Share extends StatelessWidget {
  final BuildContext navContext;

  Share({this.navContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerWidget(navContext: navContext),
      appBar:
          AppBar(backgroundColor: Colors.deepPurple[800], title: Text('Share')),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
              child: Center(
                child: Text(
                  'Coming Soon!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Image.asset('assets/a.jpg'),
          ],
        ),
      ),
    );
  }
}
