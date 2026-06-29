class ApiResponse<T> {
  final T data;
  final bool success;
  final String? message;
  final String? token;

  const ApiResponse({
    required this.data,
    required this.success,
    this.message,
    this.token,
  });
}
