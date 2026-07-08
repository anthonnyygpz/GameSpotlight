class ApiResponse<T> {
  const ApiResponse({
    this.data,
    required this.success,
    this.message,
    this.error,
  });

  final bool success;
  final String? message;
  final T? data;
  final String? error;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic map)? fromJsonT,
  ]) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}
