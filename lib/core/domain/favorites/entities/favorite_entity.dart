class FavoriteEntity {
  const FavoriteEntity({
    required this.gameId,
    required this.title,
    required this.slug,
    required this.coverImage,
    required this.status,
    required this.addedAt,
    required this.generes,
  });

  final String gameId;
  final String title;
  final String slug;
  final String coverImage;
  final String status;
  final String addedAt;
  final String generes;
}
