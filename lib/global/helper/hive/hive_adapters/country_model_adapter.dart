import 'package:hive_flutter/adapters.dart';

class LanguageModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? code;

  LanguageModel({required this.name, required this.code});
}

@HiveType(typeId: 2, adapterName: 'CountryModelAdapter')
class CountryModelAdapter extends TypeAdapter<LanguageModel> {
  @override
  LanguageModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageModel(
      name: fields[0] as String,
      code: fields[1] as String,
    );
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.code);
  }
}
