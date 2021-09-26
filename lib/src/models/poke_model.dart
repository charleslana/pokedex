class PokeModel {
  PokeModel({required this.pokemon});

  PokeModel.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      json['pokemon'].forEach((dynamic value) {
        pokemon.add(Pokemon.fromJson(value));
      });
    }
  }

  List<Pokemon> pokemon = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pokemon'] = pokemon.map((value) => value.toJson()).toList();
    return data;
  }
}

class Pokemon {
  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.atk,
    required this.sta,
    required this.def,
    required this.generation,
    required this.description,
    required this.weight,
    required this.height,
    required this.preEvolution,
    required this.nextEvolution,
    required this.maxCp,
    required this.resistant,
    required this.weaknesses,
    required this.moves,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'] = Type.fromJson(json['type']);
    atk = json['atk'];
    sta = json['sta'];
    def = json['def'];
    generation = json['generation'];
    description = Description.fromJson(json['description']);
    weight = json['weight'];
    height = json['height'];
    if (json['pre_evolution'] != null) {
      final List<PreEvolution> preEvolution = [];
      json['pre_evolution'].forEach((dynamic value) {
        preEvolution.add(PreEvolution.fromJson(value));
      });
    }
    if (json['next_evolution'] != null) {
      final List<NextEvolution> nextEvolution = [];
      json['next_evolution'].forEach((dynamic value) {
        nextEvolution.add(NextEvolution.fromJson(value));
      });
    }
    maxCp = json['max_cp'];
    resistant = Type.fromJson(json['resistant']);
    weaknesses = Type.fromJson(json['weaknesses']);
    moves = Type.fromJson(json['moves']);
  }

  late int id;
  late String num;
  late String name;
  late String img;
  late Type type;
  late int atk;
  late int sta;
  late int def;
  late int generation;
  late Description description;
  late double weight;
  late double height;
  late List<PreEvolution> preEvolution;
  late List<NextEvolution> nextEvolution;
  late int maxCp;
  late Type resistant;
  late Type weaknesses;
  late Type moves;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    data['img'] = img;
    data['type'] = type.toJson();
    data['atk'] = atk;
    data['sta'] = sta;
    data['def'] = def;
    data['generation'] = generation;
    data['description'] = description.toJson();
    data['weight'] = weight;
    data['height'] = height;
    data['pre_evolution'] =
        preEvolution.map((value) => value.toJson()).toList();
    data['next_evolution'] =
        nextEvolution.map((value) => value.toJson()).toList();
    data['max_cp'] = maxCp;
    data['resistant'] = resistant.toJson();
    data['weaknesses'] = weaknesses.toJson();
    data['moves'] = moves.toJson();

    return data;
  }
}

class Type {
  Type({
    required this.en,
    required this.ptBr,
  });

  Type.fromJson(Map<String, dynamic> json) {
    en = json['en'].cast<String>();
    ptBr = json['pt_br'].cast<String>();
  }

  late List<String> en;
  late List<String> ptBr;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['en'] = en;
    data['pt_br'] = ptBr;
    return data;
  }
}

class Description {
  Description({
    required this.en,
    required this.ptBr,
  });

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ptBr = json['pt_br'];
  }

  late String en;
  late String ptBr;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['en'] = en;
    data['pt_br'] = ptBr;
    return data;
  }
}

class PreEvolution {
  PreEvolution({
    required this.id,
    required this.num,
    required this.name,
  });

  PreEvolution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
  }

  late int id;
  late String num;
  late String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}

class NextEvolution {
  NextEvolution({
    required this.id,
    required this.num,
    required this.name,
  });

  NextEvolution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
  }

  late int id;
  late String num;
  late String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}
