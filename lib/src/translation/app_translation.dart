class AppTranslation {
  Map<String, Map<String, String>> translationsKeys = {
    'en_US': enUS,
    'pt_BR': ptBR,
  };
}

final Map<String, String> enUS = {
  'greeting': 'Hello, How are you?',
  'day': 'Awesome day...'
};

final Map<String, String> ptBR = {
  'greeting': 'Olá, como vai?',
  'day': 'Dia sensacional...'
};
