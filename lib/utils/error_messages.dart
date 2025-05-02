import 'package:dio/dio.dart';

String mapDioErrorToMessage(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Sunucuya ulaşılamadı. Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        return 'Sunucudan beklenmedik yanıt alındı (kod: $status).';
      case DioExceptionType.cancel:
        return 'İstek iptal edildi.';
      case DioExceptionType.connectionError:
        return 'İnternet bağlantı hatası oluştu. Lütfen bağlantınızı kontrol edin.';
      case DioExceptionType.badCertificate:
        return 'Güvenlik sertifikası doğrulanamadı.';
      case DioExceptionType.unknown:
      default:
        return 'Beklenmedik bir ağ hatası oluştu.';
    }
  }
  return 'Beklenmedik bir hata oluştu.';
}
