class ReciterModel {
  final int id;
  final String name;
  final String server;
  final int surah_total;
  final int moshaf_type;
  final List<String> surah_list;
  const ReciterModel({
    required this.id,
    required this.name,
    required this.server,
    required this.surah_total,
    required this.moshaf_type,
    required this.surah_list,
  });

  factory ReciterModel.fromJson(jsonData) {
    return ReciterModel(
      id: jsonData['id'],
      name: jsonData['name'],
      server: jsonData['server'],
      surah_total: jsonData['surah_total'],
      moshaf_type: jsonData['moshaf_type'],
      surah_list: (jsonData['surah_list'] as String).split(','),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'server': server,
      'surah_total': surah_total,
      'moshaf_type': moshaf_type,
      'surah_list': surah_list ,
    };
  }
}
