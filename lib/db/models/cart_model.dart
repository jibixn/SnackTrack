

import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 1)

class cartModel{
  @HiveField(0)
  int? key;


  @HiveField(1)
  String Id;


  @HiveField(2)
  String item;


  @HiveField(3)
  String price;

  @HiveField(4)
  String quantity;
  cartModel(
    {
      this.key,
      required this.Id,
      required this.item,
      required this.price,
      required this.quantity
    }
  );
}