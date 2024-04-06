import 'package:flutter_test/flutter_test.dart';
import 'package:teste_cars/src/models/car_model.dart';

void main() {
  group('Car Model', () {
    test('fromJson returns a valid Car instance', () {
      final json = {'id': 1, 'nome_modelo': 'Test Car', 'valor': 10000.0};
      final car = Car.fromJson(json);

      expect(car, isA<Car>());
      expect(car.id, json['id']);
      expect(car.nomeModelo, json['nome_modelo']);
      expect(car.valor, json['valor']);
    });

    test('toJson returns a JSON map representing the Car instance', () {
      final car = Car(
        id: 1,
        nomeModelo: 'Test Car',
        valor: 10000.0,
        ano: 2018,
        combustivel: '',
        numPortas: 4,
        cor: '',
      );
      final json = car.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], car.id);
      expect(json['nome_modelo'], car.nomeModelo);
      expect(json['valor'], car.valor);
    });
  });
}
