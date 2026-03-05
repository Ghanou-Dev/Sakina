// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_surah_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedSurahModelAdapter extends TypeAdapter<SavedSurahModel> {
  @override
  final typeId = 1;

  @override
  SavedSurahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedSurahModel(
      numberSurah: (fields[0] as num).toInt(),
      surahArabicName: fields[1] as String,
      surahEnglishName: fields[2] as String,
      reciterName: fields[3] as String,
      mushafeName: fields[4] as String,
      surahUrl: fields[5] as String,
      type: fields[6] as String,
      numberVerses: (fields[7] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedSurahModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.numberSurah)
      ..writeByte(1)
      ..write(obj.surahArabicName)
      ..writeByte(2)
      ..write(obj.surahEnglishName)
      ..writeByte(3)
      ..write(obj.reciterName)
      ..writeByte(4)
      ..write(obj.mushafeName)
      ..writeByte(5)
      ..write(obj.surahUrl)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.numberVerses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedSurahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
