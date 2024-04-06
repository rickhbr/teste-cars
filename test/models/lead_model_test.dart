import 'package:flutter_test/flutter_test.dart';
import 'package:teste_cars/src/models/lead_model.dart';

void main() {
  group('Lead Model', () {
    test('toJson returns a JSON map representing the Lead instance', () {
      final lead = Lead(
          name: 'Test', email: 'test@test.com', phone: '1234567890', carId: 1);
      final json = lead.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['name'], lead.name);
      expect(json['email'], lead.email);
      expect(json['phone'], lead.phone);
      expect(json['carId'], lead.carId);
    });

    test('fromMap creates a valid Lead instance', () {
      final map = {
        'name': 'Test',
        'email': 'test@test.com',
        'phone': '1234567890',
        'carId': 1
      };
      final lead = Lead.fromMap(map);

      expect(lead, isA<Lead>());
      expect(lead.name, map['name']);
      expect(lead.email, map['email']);
      expect(lead.phone, map['phone']);
      expect(lead.carId, map['carId']);
    });
  });
}
