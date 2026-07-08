class GamePlatformEntity {
  const GamePlatformEntity({
    required this.gameId,
    required this.platform,
    required this.title,
    required this.description,
    required this.coverImage,
    this.status,
  });

  final String gameId;
  final String title;
  final String platform;
  final String description;
  final String coverImage;
  final String? status;
}
