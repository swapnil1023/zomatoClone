import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_app/functionalities/local_data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Future<bool> wait() {
  return Future.delayed(Duration(seconds: 3)).then((value) => true);
}

class _MainScreenState extends State<MainScreen> {
  LocalData localData = new LocalData();
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink, Colors.deepPurple])),
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.1),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: Colors.black54,
                          //   radius: 140,
                          // ),
                          Image.asset(
                            'assets/images/LOGO2.png',
                            height: 230,
                            width: 230,
                          ),
                          //CircleAvatar(backgroundColor: Colors.black54,radius: 140,),
                          Positioned(
                            top: 70,
                            child: Image.asset(
                              'assets/images/LOGO1.png',
                              height: 130,
                              width: 130,
                            ),
                          ),
                          Positioned(
                              bottom: 30,
                              child: Hero(
                                tag: 'porsio',
                                child: Text(
                                  'Porsio',
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: localData.checkLoggedIn(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == true) {
                              wait().then((value) {
                                Navigator.of(context)
                                    .popAndPushNamed('/navigation');
                              });
                              return Center(
                                  child: SpinKitChasingDots(
                                color: Colors.pink,
                              ));

                              // return FutureBuilder(
                              //   future: wait(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasData) {
                              //       Navigator.of(context)
                              //           .popAndPushNamed('/navigation');
                              //     }
                              //     return Center(
                              //         child: SpinKitChasingDots(
                              //       color: Colors.purple,
                              //     ));
                              //   },
                              // );
                              // return RaisedButton(
                              //     color: Color.fromARGB(255, 90, 14, 151),
                              //     padding:
                              //         EdgeInsets.only(left: 120, right: 120),
                              //     child: Text(
                              //       'Continue',
                              //       textAlign: TextAlign.center,
                              //       style: TextStyle(
                              //         color: Color.fromARGB(255, 255, 255, 255),
                              //         fontSize: 15,
                              //       ),
                              //     ),
                              //     splashColor:
                              //         Color.fromARGB(255, 144, 28, 238),
                              //     elevation: 10,
                              //     onPressed: () {
                              //       Navigator.of(context)
                              //           .popAndPushNamed('/navigation');
                              //     });
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    height: 100,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/login_screen');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: Text(
                                        'Get Started',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     Padding(
                              //       padding: EdgeInsets.only(
                              //         bottom: 50,
                              //       ),
                              //     ),
                              //     RaisedButton(
                              //         color: Color.fromARGB(255, 90, 14, 151),
                              //         padding: EdgeInsets.only(
                              //             left: 120, right: 120),
                              //         child: Text(
                              //           'SignUp',
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color.fromARGB(
                              //                 255, 255, 255, 255),
                              //             fontSize: 15,
                              //           ),
                              //         ),
                              //         splashColor:
                              //             Color.fromARGB(255, 144, 28, 238),
                              //         elevation: 10,
                              //         onPressed: () {
                              //           Navigator.of(context)
                              //               .pushNamed('/signUp_email');
                              //         }),
                              //     RaisedButton(
                              //         materialTapTargetSize:
                              //             MaterialTapTargetSize.padded,
                              //         padding: EdgeInsets.only(
                              //             left: 120, right: 120),
                              //         child: Text(
                              //           'SignIn',
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Color.fromARGB(
                              //                 255, 255, 255, 255),
                              //             fontSize: 15,
                              //           ),
                              //         ),
                              //         color: Color.fromARGB(255, 90, 14, 151),
                              //         elevation: 10,
                              //         splashColor:
                              //             Color.fromARGB(255, 144, 28, 238),
                              //         onPressed: () {
                              //           Navigator.of(context)
                              //               .pushNamed('/login_screen');
                              //         }),
                              //   ],
                              // );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
