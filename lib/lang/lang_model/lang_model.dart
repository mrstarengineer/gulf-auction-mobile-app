
class Language {
  final int id;
  final String flag;
  final String name;
  final String code;

  Language(this.id, this.flag, this.name, this.code);

  static List<Language> languageList = [
    Language(1, 'assets/icons/flags/us-flag.svg', 'English', 'en'),
    Language(2, 'assets/icons/flags/uae-flag.svg', 'Arabic', 'ar'),
  ];

}