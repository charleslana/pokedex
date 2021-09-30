class AppTranslation {
  Map<String, Map<String, String>> translationsKeys = {
    'en_US': enUS,
    'pt_BR': ptBR,
  };
}

final Map<String, String> enUS = {
  'languageCode': 'en',
  'menuLanguage': 'Language',
  'menuDarkTheme': 'Dark Theme',
  'menuAbout': 'About',
};

final Map<String, String> ptBR = {
  'languageCode': 'pt',
  'menuLanguage': 'Idioma',
  'menuDarkTheme': 'Tema Escuro',
  'menuAbout': 'Sobre',
};
