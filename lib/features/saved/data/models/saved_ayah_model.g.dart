// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_ayah_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedAyahModelAdapter extends TypeAdapter<SavedAyahModel> {
  @override
  final typeId = 0;

  @override
  SavedAyahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedAyahModel(
      textArabic: fields[0] as String,
      textEnglish: fields[1] as String,
      taffsir: fields[2] as String,
      ayahNumber: (fields[3] as num).toInt(),
      surahArabicName: fields[4] as String,
      surahEnglishName: fields[5] as String,
      surahNumber: (fields[6] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedAyahModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.textArabic)
      ..writeByte(1)
      ..write(obj.textEnglish)
      ..writeByte(2)
      ..write(obj.taffsir)
      ..writeByte(3)
      ..write(obj.ayahNumber)
      ..writeByte(4)
      ..write(obj.surahArabicName)
      ..writeByte(5)
      ..write(obj.surahEnglishName)
      ..writeByte(6)
      ..write(obj.surahNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedAyahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
