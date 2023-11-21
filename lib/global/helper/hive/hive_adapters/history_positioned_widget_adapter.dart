import 'package:hive_flutter/adapters.dart';

class HistoryPositionedWidgetModel {
  @HiveField(0)
  int x;
  @HiveField(1)
  int y;
  @HiveField(2)
  double angle;
  @HiveField(3)
  double width;
  @HiveField(4)
  double height;
  @HiveField(5)
  String text;

  HistoryPositionedWidgetModel({
    required this.x,
    required this.y,
    required this.angle,
    required this.width,
    required this.height,
    required this.text,
  });
}

@HiveType(typeId: 1, adapterName: 'HistoryPositionedWidgetAdapter')
class HistoryPositionedWidgetAdapter
    extends TypeAdapter<HistoryPositionedWidgetModel> {
  @override
  HistoryPositionedWidgetModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryPositionedWidgetModel(
      x: fields[0] as int,
      y: fields[1] as int,
      angle: fields[2] as double,
      width: fields[3] as double,
      height: fields[4] as double,
      text: fields[5] as String,
    );
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y)
      ..writeByte(2)
      ..write(obj.angle)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.text);
  }
}
