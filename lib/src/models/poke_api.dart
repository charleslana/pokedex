class PokeApi {
  PokeApi({required this.pokemon});

  PokeApi.fromJson(Map<String, dynamic> json) {
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
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'].cast<String>();
    height = json['height'];
    weight = json['weight'];
    candy = json['candy'];
    candyCount = json['candy_count'];
    egg = json['egg'];
    spawnChance = json['spawn_chance'];
    avgSpawns = json['avg_spawns'];
    spawnTime = json['spawn_time'];
    if (multipliers.isNotEmpty) {
      multipliers = json['multipliers']!.cast<double>();
    }
    weaknesses = json['weaknesses'].cast<String>();
    if (json['next_evolution'] != null) {
      final List<NextEvolution> nextEvolution = [];
      json['next_evolution'].forEach((dynamic value) {
        nextEvolution.add(NextEvolution.fromJson(value));
      });
    }
    if (json['prev_evolution'] != null) {
      final List<PrevEvolution> prevEvolution = [];
      json['prev_evolution'].forEach((dynamic value) {
        prevEvolution.add(PrevEvolution.fromJson(value));
      });
    }
  }

  late int id;
  late String num;
  late String name;
  late String img;
  late List<String> type;
  late String height;
  late String weight;
  late String candy;
  late int? candyCount;
  late String egg;
  late double spawnChance;
  late double avgSpawns;
  late String spawnTime;
  List<double> multipliers = [];
  late List<String> weaknesses;
  late List<NextEvolution> nextEvolution;
  late List<PrevEvolution> prevEvolution;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['height'] = height;
    data['weight'] = weight;
    data['candy'] = candy;
    data['candy_count'] = candyCount;
    data['egg'] = egg;
    data['spawn_chance'] = spawnChance;
    data['avg_spawns'] = avgSpawns;
    data['spawn_time'] = spawnTime;
    data['multipliers'] = multipliers;
    data['weaknesses'] = weaknesses;
    data['next_evolution'] =
        nextEvolution.map((value) => value.toJson()).toList();
    data['prev_evolution'] =
        prevEvolution.map((value) => value.toJson()).toList();
    return data;
  }
}

class NextEvolution {
  NextEvolution({
    required this.num,
    required this.name,
  });

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  late String num;
  late String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}

class PrevEvolution {
  PrevEvolution({
    required this.num,
    required this.name,
  });

  PrevEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  late String num;
  late String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}
