class MoshafeModel {
  final int id;
  final String name;
  final String server;
  final int surahTotal;
  final int moshafType;
  final List<String> surahList;

  MoshafeModel({
    required this.id,
    required this.name,
    required this.server,
    required this.surahTotal,
    required this.moshafType,
    required this.surahList,
  });

  // factory MoshafeModel.fromJson(jsonData) {
  //   return MoshafeModel(
  //     id: jsonData[ReciterKeys.id],
  //     name: jsonData[ReciterKeys.name],
  //     server: jsonData[ReciterKeys.server],
  //     surahTotal: jsonData[ReciterKeys.surahTotal],
  //     moshafType: jsonData[ReciterKeys.moshafType],
  //     surahList: jsonData[ReciterKeys.surahList],
  //   );
  // }
}
