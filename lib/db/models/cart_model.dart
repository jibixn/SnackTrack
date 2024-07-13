

import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 1)

class cartModel{
  @HiveField(0)
  int? key;


  @HiveField(1)
  String item;


  @HiveField(2)
  String price;

  @HiveField(3)
  String quantity;
  cartModel(
    {
      this.key,
      required this.item,
      required this.price,
      required this.quantity
    }
  );
}