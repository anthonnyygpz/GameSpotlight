class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String upcomingReleases = '/upcoming-releases';
  static const String exclusiveTrailers = '/exclusive-trailers';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String gameDetails = '/game-details';
  static String gameDetailsPath(String id) => '/game-details/$id';
  static const String favorites = '/favorites';
  static const String genres = '/genres';
  static const String gameGenre = '/game-genre';
  static String gameGenrePath(String id) => '/game-genre/$id';
  static const String platforms = '/platforms';
  static const String gamePlatforms = '/game-platforms';
  static String gamePlatformsPath(String id) => '/game-platforms/$id';
}
