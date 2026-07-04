class GameEntity {
  const GameEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.gradientStart,
    required this.gradiendEnd,
    required this.badge,
    required this.date,
    required this.category,
    required this.coverImageUrl,
    required this.bannerUrl,
    required this.genres,
    required this.platforms,
    required this.totalTrailers,
    required this.featured,
    required this.status,
  });

  final String id;
  final String title;
  final String subtitle;
  final String gradientStart;
  final String gradiendEnd;
  final String? badge;
  final DateTime? date;
  final String category;
  final String coverImageUrl;
  final String bannerUrl;
  final String genres;
  final String platforms;
  final String totalTrailers;
  final String featured;
  final String status;
}
