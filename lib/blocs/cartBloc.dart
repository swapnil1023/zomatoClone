import 'dart:async';

import 'package:my_flutter_app/functionalities/sql_service.dart';
import 'package:my_flutter_app/models/addressModel.dart';
import 'package:my_flutter_app/models/cartItem.dart';

class CartBloc {
  String userId;
  CartBloc({this.userId}) {
    getCartItems(userId);
  }

  final _cartController = StreamController<List<CartItem>>.broadcast();

  get cartItems => _cartController.stream;

  getCartItems(String userId) async {
    _cartController.sink.add(await DBProvider.db.getCartItems(userId));
  }

  Future<void> deleteAddress(int addrId) async {
    await DBProvider.db.deleteAddress(addrId);
    await getCartItems(userId);
  }

  Future<void> insertAddress(Map<String, dynamic> address) async {
    await DBProvider.db.insertAddress(address);
    await getCartItems(userId);
  }

  dispose() {
    _cartController.close();
  }
}
