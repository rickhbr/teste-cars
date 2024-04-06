import 'package:teste_cars/src/network/api_client.dart';
import 'package:teste_cars/src/repository/car_repository.dart';

class Injector {
  static ApiClient _createApiClient() {
    return ApiClient();
  }

  static CarRepository provideCarRepository() {
    final apiClient = _createApiClient();
    return CarRepository(apiClient: apiClient);
  }
}
