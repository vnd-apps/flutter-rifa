// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckoutAdapter extends TypeAdapter<Checkout> {
  @override
  final int typeId = 6;

  @override
  Checkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Checkout(
      products: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Checkout obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
