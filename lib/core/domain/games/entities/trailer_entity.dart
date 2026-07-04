class TrailerEntity {
  const TrailerEntity({
    required this.trailerId,
    required this.title,
    required this.type,
    required this.videoUrl,
    required this.posterUrl,
    required this.sortOrder,
    required this.categories,
  });

  final String trailerId;
  final String title;
  final String type;
  final String videoUrl;
  final String? posterUrl;
  final int sortOrder;
  final String categories;
}
