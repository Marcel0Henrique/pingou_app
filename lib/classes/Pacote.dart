import 'package:dio/dio.dart';
import 'package:pingou_app/keys.dart';

class Pacote {
  Future<String> Rastreiar(String? cod) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = "https://api.linketrack.com"
      ..connectTimeout = 5000
      ..responseType = ResponseType.plain
      ..contentType = 'application/json';

    try {
      var response = await dio
          .get("/track/json?user=${user}&token=${token}&codigo=${cod}");
      return response.data.toString();
    } on DioError catch (e) {
      if (e.type == DioErrorType.cancel) {
        throw "Requisição cancelada pelo servidor";
      } else if (e.type == DioErrorType.connectTimeout) {
        throw "Erro de conexão com o servidor";
      } else if (e.type == DioErrorType.receiveTimeout) {
        throw "Tempo limite de tempo com conexão do servidor atingida";
      } else if (e.type == DioErrorType.sendTimeout) {
        throw "Limite de tempo para envio de informações para o servidor atingido";
      } else if (e.type == DioErrorType.response) {
        throw e.response.toString();
      } else {
        throw e;
      }
    }
  }
}
