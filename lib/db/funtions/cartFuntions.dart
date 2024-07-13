import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snack_track/db/models/cart_model.dart';

ValueNotifier<List<cartModel>> cartItemsNotifier = ValueNotifier([]);

Future<void> addItem(cartModel value) async {
  final cartDB = await Hive.openBox<cartModel>('cart_db');
  final _id = await cartDB.add(value);
  value.key = _id;

  cartItemsNotifier.value.add(value);
  cartItemsNotifier.notifyListeners();
}

Future<void> getAllItems() async {
  final cartDB = await Hive.openBox<cartModel>('cart_db');
  cartItemsNotifier.value.clear();
  cartItemsNotifier.value.addAll(cartDB.values.cast<cartModel>());
  cartItemsNotifier.notifyListeners();
}

Future<void> deleteCart() async {
  final cartDB = await Hive.openBox<cartModel>('cart_db');
  await cartDB.clear();
  cartItemsNotifier.value.clear(); 
  cartItemsNotifier.notifyListeners();
}
