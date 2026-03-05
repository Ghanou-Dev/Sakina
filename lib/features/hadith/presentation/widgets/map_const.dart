Map<String, dynamic> replaceWolds = {
  'Sahih': 'حديث صحيح',
  'sahih': 'حديث صحيح',
  'Da`eef': 'حديث ضعيف',
};

extension ReplaceWorldX on String {
  String get getWorld {
    return replaceWolds[this] ?? this;
  }
}
