import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'api_client_test.mocks.dart';

import 'package:teste_cars/src/network/api_client.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late ApiClient apiClient;
  const String testUrl = 'https://wswork.com.br/cars.json';

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClient(httpClient: mockDio);
  });

  group('ApiClient Tests', () {
    test(
        'getCarList returns a list of cars if http call completes successfully',
        () async {
      final List<Map<String, dynamic>> testData = [
        {'id': 1, 'nome_modelo': 'Car', 'valor': 10000}
      ];
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
            data: {'cars': testData},
            statusCode: 200,
            requestOptions: RequestOptions(path: testUrl)),
      );

      final carList = await apiClient.getCarList(testUrl);
      expect(carList, isA<List<Car>>());
      expect(carList.isNotEmpty, isTrue);
    });

    test('getCarList throws an exception if http call completes with error',
        () async {
      when(mockDio.get(any)).thenThrow(
        DioException(
            response: Response(
                statusCode: 404, requestOptions: RequestOptions(path: testUrl)),
            requestOptions: RequestOptions(path: testUrl)),
      );

      expect(apiClient.getCarList(testUrl), throwsException);
    });
  });
}
