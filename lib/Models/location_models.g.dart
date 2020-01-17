// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelAdapter extends TypeAdapter<LocationModel> {
  @override
  LocationModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModel()
      .._locationId = fields[0] as int
      .._locationName = fields[1] as String
      .._state = fields[2] as String
      .._type = fields[3] as String
      .._pic = fields[4] as String
      .._description = fields[5] as String
      .._lat = fields[6] as double
      .._longitude = fields[7] as double;
  }

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj._locationId)
      ..writeByte(1)
      ..write(obj._locationName)
      ..writeByte(2)
      ..write(obj._state)
      ..writeByte(3)
      ..write(obj._type)
      ..writeByte(4)
      ..write(obj._pic)
      ..writeByte(5)
      ..write(obj._description)
      ..writeByte(6)
      ..write(obj._lat)
      ..writeByte(7)
      ..write(obj._longitude);
  }
}
