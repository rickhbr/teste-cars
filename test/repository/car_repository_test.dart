import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/models/lead_model.dart';
import 'car_repository_test.mocks.dart';
import 'package:teste_cars/src/network/api_client.dart';
import 'package:teste_cars/src/repository/car_repository.dart';

@GenerateMocks([ApiClient, Database])
void main() {
  late MockApiClient mockApiClient;
  late MockDatabase mockDatabase;
  late CarRepository carRepository;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    mockApiClient = MockApiClient();
    mockDatabase = MockDatabase();
    carRepository =
        CarRepository(apiClient: mockApiClient, database: mockDatabase);
  });

  test('fetchCars returns a list of cars', () async {
    // Preparando o mock para retornar uma lista de carros quando getCarList for chamado
    when(mockApiClient.getCarList(any)).thenAnswer((_) async => [
          Car(
              id: 1,
              nomeModelo: 'Car 1',
              valor: 10000,
              ano: 2018,
              combustivel: '',
              numPortas: 4,
              cor: ''),
          Car(
              id: 2,
              nomeModelo: 'Car 2',
              valor: 20000,
              ano: 2020,
              combustivel: '',
              numPortas: 2,
              cor: ''),
        ]);

    // Chamada ao método sob teste
    final cars = await carRepository.fetchCars();

    // Verificando o resultado
    expect(cars, isA<List<Car>>());
    expect(cars.length, 2);
  });

  test('sendLeadToServer sends a lead', () async {
    // Prepare o lead a ser enviado
    final lead = Lead(
        name: 'Test Name',
        email: 'test@test.com',
        phone: '1234567890',
        carId: 1);

    // Chamada ao método sob teste
    await carRepository.sendLeadToServer(lead: lead);

    // Verifique se o método foi chamado
    verify(mockApiClient.sendLead(any, any)).called(1);
  });

  test('submitLead inserts a lead into the database', () async {
    when(mockDatabase.insert(any, any,
            conflictAlgorithm: anyNamed('conflictAlgorithm')))
        .thenAnswer((_) async => 1);
    await carRepository.submitLead(
      name: "Test Name",
      email: "test@example.com",
      phone: "1234567890",
      carId: 1,
    );

    // Verifica se o método insert foi chamado no mockDatabase com os argumentos esperados.
    verify(mockDatabase.insert(
      'leads',
      any,
      conflictAlgorithm: ConflictAlgorithm.replace,
    )).called(1);
  });
}
