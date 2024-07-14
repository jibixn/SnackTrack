// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class cartModelAdapter extends TypeAdapter<cartModel> {
  @override
  final int typeId = 1;

  @override
  cartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return cartModel(
      key: fields[0] as int?,
      Id: fields[1] as String,
      item: fields[2] as String,
      price: fields[3] as String,
      quantity: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, cartModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is cartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
