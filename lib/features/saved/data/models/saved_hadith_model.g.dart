// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_hadith_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedHadithModelAdapter extends TypeAdapter<SavedHadithModel> {
  @override
  final typeId = 2;

  @override
  SavedHadithModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedHadithModel(
      hadithArabic: fields[0] as String,
      hadithEnglish: fields[1] as String,
      headingArabic: fields[2] as String?,
      headingEnglish: fields[3] as String?,
      chapterArabic: fields[4] as String?,
      chapterEnglish: fields[5] as String?,
      status: fields[6] as String,
      englishNarrator: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedHadithModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.hadithArabic)
      ..writeByte(1)
      ..write(obj.hadithEnglish)
      ..writeByte(2)
      ..write(obj.headingArabic)
      ..writeByte(3)
      ..write(obj.headingEnglish)
      ..writeByte(4)
      ..write(obj.chapterArabic)
      ..writeByte(5)
      ..write(obj.chapterEnglish)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.englishNarrator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedHadithModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
