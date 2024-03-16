class Game {
  final String? name;
  final dynamic genre;
  final dynamic developers;
  final dynamic publishers;
  final dynamic releaseDates;

  Game({
    this.name,
    this.genre,
    this.developers,
    this.publishers,
    this.releaseDates,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      genre: json['genre'],
      developers: json['developers'],
      publishers: json['publishers'],
      releaseDates: json['release_dates'],
    );
  }
}
