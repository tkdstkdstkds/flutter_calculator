// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_repository.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomePageListModelAdapter extends TypeAdapter<HomePageListModel> {
  @override
  final int typeId = 0;

  @override
  HomePageListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomePageListModel(
      items: (fields[0] as List).cast<HomePageListItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HomePageListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HomePageListItemModelAdapter extends TypeAdapter<HomePageListItemModel> {
  @override
  final int typeId = 1;

  @override
  HomePageListItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomePageListItemModel(
      itemName: fields[0] as String,
      itemSinglePrice: fields[1] as double,
      itemCount: fields[2] as int,
      itemTotalPrice: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HomePageListItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.itemSinglePrice)
      ..writeByte(2)
      ..write(obj.itemCount)
      ..writeByte(3)
      ..write(obj.itemTotalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageListItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
