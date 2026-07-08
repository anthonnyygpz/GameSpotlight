class GameEntity {
  const GameEntity({
    required this.id,
    required this.title,
    this.slug,
    this.synopsis,
    this.releaseDate,
    this.developer,
    this.editor,
    required this.coverImageUrl,
    this.bannerUrl,
    required this.status,
    this.featured,
    this.genres,
    this.platforms,
    this.totalTrailers,
  });

  final String id;
  final String title;
  final String? slug;
  final String? synopsis;
  final DateTime? releaseDate;
  final String? developer;
  final String? editor;
  final String coverImageUrl;
  final String? bannerUrl;
  final String status;
  final String? featured;
  final String? genres;
  final String? platforms;
  final String? totalTrailers;
}
