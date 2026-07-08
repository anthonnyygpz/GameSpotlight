class TrailerEntity {
  const TrailerEntity({
    required this.trailerId,
    required this.title,
    required this.videoUrl,
    required this.posterUrl,
    required this.sortOrder,
    required this.type,
    required this.categories,
  });

  final String trailerId;
  final String title;
  final String videoUrl;
  final String? posterUrl;
  final String sortOrder;
  final String type;
  final List<dynamic>? categories;
}
