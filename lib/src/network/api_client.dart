import 'package:dio/dio.dart';

import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/utils/loggy/types.dart';

class ApiClient with ApiClientLoggy {
  Dio httpClient;
  ApiClient({Dio? httpClient}) : httpClient = httpClient ?? Dio();

  Future<List<Car>> getCarList(String url) async {
    try {
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> carJsonList = response.data['cars'];
        List<Car> cars = carJsonList
            .map<Car>(
                (jsonItem) => Car.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
        return cars;
      } else {
        throw Exception(
            'Failed to load cars with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      loggy.debug('ApiClient.getCarList DioError: ${e.message}');
      throw Exception('Failed to load cars: ${e.response?.data}');
    }
  }

  Future<void> sendLead(String url, Map<String, dynamic> leadData) async {
    loggy.debug('Mockando POST request para o URL: $url com dados: $leadData');

    // Simula uma pequena espera para imitar a latência da rede
    await Future.delayed(const Duration(seconds: 1));

    // Mockando a resposta do servidor como se fosse bem-sucedida
    try {
      loggy.debug('Lead mockado enviado com sucesso para o servidor.');
    } catch (e) {
      loggy.debug('Erro ao enviar lead mockado: $e');
      throw Exception('Erro mockado: $e');
    }
  }
}
