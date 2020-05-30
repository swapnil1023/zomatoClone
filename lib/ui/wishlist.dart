import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_app/functionalities/firestore_service.dart';
import 'package:my_flutter_app/functionalities/local_data.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.deepPurple[700],
            title: Text(
              'Wishlist',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  child: FutureBuilder(
                    future: LocalData().getUid(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                            child:
                                SpinKitChasingDots(color: Colors.deepPurple));
                      String userId = snapshot.data;
                      return StreamBuilder(
                        stream: FirestoreService().getUser(userId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: SpinKitChasingDots(
                                color: Colors.purple,
                              ),
                            );
                          DocumentSnapshot document = snapshot.data;
                          List wishlist = document['wishlist'];
                          return StreamBuilder(
                            stream: FirestoreService().getWishlistProducts(wishlist),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                  child: SpinKitChasingDots(
                                    color: Colors.purple,
                                  ),
                                );
                              return Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  children: List.generate(wishlist.length,(index){
                                    DocumentSnapshot document =
                                        snapshot.data.documents[index];
                                    return itemCard(
                                        document['name'],
                                        document['catalogue'][0],
                                        document['description'],
                                        wishlist.contains(document.documentID),
                                        '\u{20B9}' + document['price'],
                                        document,
                                        context);
                                  }),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemCard(String name, String imgPath, String description, bool inWishlist,
    String price, DocumentSnapshot document, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 2, bottom: 2),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.purple,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 10),
        child: Container(
          //card
          height: 180,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 12,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/description', arguments: document);
                  },
                  child: Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Flexible(
                flex: 20,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 7,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/description',
                                      arguments: document);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                          (2 / 3) *
                                          (3 / 4) -
                                      10,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // Flexible(
                            //   flex: 1,
                            //   child: SizedBox(),
                            // ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                child: Material(
                                  elevation: inWishlist ? 2 : 0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        (1 / 3) *
                                        (1 / 4),
                                    width: MediaQuery.of(context).size.width *
                                        (1 / 3) *
                                        (1 / 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              (1 / 3) *
                                              (1 / 8)),
                                      color: inWishlist
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: inWishlist
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons.favorite_border),
                                        iconSize:
                                            MediaQuery.of(context).size.width *
                                                    (1 / 3) *
                                                    (1 / 8) -
                                                1,
                                        onPressed: () {
                                          FirestoreService().addToWishlist(
                                              document.documentID);

                                          // FirestoreService().changeFav(
                                          //     document.documentID, isFav);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 2 / 3,
                          child: Text(
                            description,
                            // 'Product description xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(flex: 5, child: Container()),
                            Flexible(
                              flex: 10,
                              child: Material(
                                elevation: 7,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.purple,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  height: 40,
                                  // width: MediaQuery.of(context).size.width *
                                  //     (1 / 3) *
                                  //     (1.7 / 3),
                                  child: Center(
                                    child: Text(
                                      price,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 16,
                              child: Material(
                                elevation: 7,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: Colors.purple,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple[300],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        (1 / 3) *
                                        (2.7 / 3),
                                    child: Center(
                                      child: FlatButton(
                                        onPressed: () {
                                          FirestoreService().addToCart(
                                              document.documentID, 1, false);
                                        },
                                        child: Text(
                                          'Add To Cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}