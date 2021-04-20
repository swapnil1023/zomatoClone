import 'dart:io';
import 'package:my_flutter_app/functionalities/populateDatabase.dart';
import 'package:my_flutter_app/models/addressModel.dart';
import 'package:my_flutter_app/models/orderModel.dart';
import 'package:my_flutter_app/models/productModel.dart';
import 'package:my_flutter_app/models/shopModel.dart';
import 'package:my_flutter_app/models/userModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        final populator = PopulateDatabase(db:db);
        populator.populateDB();
      },
    );
  }
  
  //Get one specific user details
  getUser(String userId) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [userId]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }
  
  // Get all address of one user
  getAddress(String userId) async {
    final db = await database;
    List<Map<String, Object>> res =
        await db.query("address", where: "userId = ?", whereArgs: [userId]);
    List<Address> addresses;
    res.forEach((add) => {addresses.add(Address.fromMap(add))});
    return addresses.isNotEmpty ? addresses : null;
  }

  //delete An address with a specific addrId
  deleteAddress(String addrId) async {
    final db = await database;
    int res =
        await db.delete("address", where: "addrId = ?", whereArgs: [addrId]);
    return res;
  }
  
  //Insert new addess into addrress table.
  insertAddress(Address address) async {
    final db = await database;
    int res = await db.insert("address", address.toMap());
    return res;
  }
  
  //Get all shops details
  getShops() async {
    final db = await database;
    List<Map<String, Object>> res = await db.query("shops");
    List<Shop> shops;
    res.forEach((shop) => {shops.add(Shop.fromMap(shop))});
    return shops.isNotEmpty ? shops : null;
  }

  //get all categories types
  getCategories() async {
    final db = await database;
    List<Map<String, Object>> res = await db.query("categories");
    return res.isNotEmpty ? res : null;
  }
 
  //get all orders for one specific user
  getOrders(String userId) async {
    final db = await database;
    List<Map<String, Object>> res =
        await db.query("orders", where: "userId = ?", whereArgs: [userId]);
    List<Order> orders;
    res.forEach((order) => {orders.add(Order.fromMap(order))});
  }

  //Get all products
  getProducts() async {
    final db = await database;
    List<Map<String, Object>> res = await db.query("products");
    List<Product> products;
    res.forEach((prod) => {products.add(Product.fromMap(prod))});
    return products.isNotEmpty ? products : null;
  }

  //Get all products for discount section
  getOfferProducts() async {
    final db = await database;
    List<Map<String, Object>> res = await db.query("products");
    List<Product> products;
    res.forEach((prod) => {products.add(Product.fromMap(prod))});
    return products.isNotEmpty ? products : null;
  }

  //get a single product based on productId
  getSingleProd(String productId) async {
    final db = await database;
    List<Map<String, Object>> res = await db
        .query("products", where: "productId = ?", whereArgs: [productId]);
    Product product = Product.fromMap(res[0]);
    return product;
  }
  
  //Get all products for one shop
  
  //Get all products for a particular category

  //product search query
  
  //shop search query
  
  //Insert into orders with Userid
  
  //Add products: productId and userId
  //remove products
}
