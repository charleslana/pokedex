final List<LanguageModel> languages = [
  LanguageModel('English', 'en_US'),
  LanguageModel('Portuguese', 'pt_BR'),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}
