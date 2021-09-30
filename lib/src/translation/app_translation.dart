class AppTranslation {
  Map<String, Map<String, String>> translationsKeys = {
    'en_US': enUS,
    'pt_BR': ptBR,
  };
}

final Map<String, String> enUS = {
  'languageCode': 'en',
  'language': 'Language',
  'darkTheme': 'Dark Theme',
  'about': 'About',
};

final Map<String, String> ptBR = {
  'languageCode': 'pt',
  'language': 'Idioma',
  'darkTheme': 'Tema Escuro',
  'about': 'Sobre',
};
