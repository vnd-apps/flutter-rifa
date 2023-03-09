// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 6;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      status: fields[1] as String,
      qrCode: fields[2] as String,
      qrCodeBase64: fields[3] as String,
      products: (fields[4] as List).cast<Product>(),
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.qrCode)
      ..writeByte(3)
      ..write(obj.qrCodeBase64)
      ..writeByte(4)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
