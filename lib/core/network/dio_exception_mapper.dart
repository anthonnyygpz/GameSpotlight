import 'package:dio/dio.dart';
import 'package:gamespotlight/core/errors/exceptions.dart';

class DioExceptionMapper {
  const DioExceptionMapper._(); // evita instanciarla, es solo un namespace de funciones

  static AppException map(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ConnectionException('Tiempo de espera agotado');

      case DioExceptionType.connectionError:
        return ConnectionException('Sin conexión a internet');

      case DioExceptionType.badResponse:
        return _mapStatusCode(e);

      case DioExceptionType.cancel:
        return ServerException('Solicitud cancelada');

      case DioExceptionType.badCertificate:
        return ServerException('Certificado de seguridad inválido');

      case DioExceptionType.unknown:
        return ServerException(e.message ?? 'Error desconocido');
    }
  }

  static AppException _mapStatusCode(DioException e) {
    final statusCode = e.response?.statusCode;
    // Intenta leer un mensaje de error específico que mande tu backend Node.js
    final serverMessage = _extractServerMessage(e.response?.data);

    switch (statusCode) {
      case 400:
        return ValidationException(serverMessage ?? 'Solicitud inválida');
      case 401:
        return InvalidCredentialsException(
          serverMessage ?? 'Credenciales inválidas',
        );
      case 403:
        return ForbiddenException(
          serverMessage ?? 'No tienes permiso para esto',
        );
      case 404:
        return NotFoundException(serverMessage ?? 'Recurso no encontrado');
      case 409:
        return ConflictException(serverMessage ?? 'El recurso ya existe');
      case 422:
        return ValidationException(serverMessage ?? 'Datos no válidos');
      case 500:
      case 502:
      case 503:
        return ServerException(serverMessage ?? 'Error del servidor');
      default:
        return ServerException(
          serverMessage ?? e.message ?? 'Error inesperado',
        );
    }
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      // Ajusta esto al shape real de tus errores del backend
      // ej: { "success": false, "message": "Email ya registrado" }
      return data['message'] as String?;
    }
    return null;
  }
}
