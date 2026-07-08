class GameGenreEntity {
  const GameGenreEntity({
    required this.genre,
    required this.gameId,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.status,
  });

  final String genre;
  final String gameId;
  final String title;
  final String description;
  final String coverImage;
  final String status;
}
