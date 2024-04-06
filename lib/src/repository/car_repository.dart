import 'package:sqflite/sqflite.dart';
import 'package:teste_cars/src/database/app_database.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/models/lead_model.dart';
import 'package:teste_cars/src/network/api_client.dart';
import 'package:teste_cars/src/utils/loggy/types.dart';

class CarRepository with CarBlocLoggy {
  final ApiClient apiClient;
  Database? _database;
  final String carsUrl = 'https://wswork.com.br/cars.json';
  final String leadsUrl = 'https://www.wswork.com.br/cars/leads/';

  CarRepository({required this.apiClient, Database? database})
      : _database = database;

  Future<Database> get _getDb async =>
      _database ??= await AppDatabase.instance.database;

  Future<List<Car>> fetchCars() async {
    final List<dynamic> carJsonList = await apiClient.getCarList(carsUrl);

    if (carJsonList.isNotEmpty && carJsonList.first is Car) {
      return carJsonList.cast<Car>();
    }

    return carJsonList
        .map<Car>((json) => Car.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> submitLead(
      {required String name,
      required String email,
      required String phone,
      required int carId}) async {
    final db = await _getDb;
    await db.insert(
      'leads',
      {'name': name, 'email': email, 'phone': phone, 'carId': carId, 'sent': 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> sendLeadToServer({required Lead lead}) async {
    try {
      await apiClient.sendLead(leadsUrl, lead.toJson());
    } catch (e) {
      loggy.debug('Erro ao enviar lead para o servidor: $e');
      rethrow;
    }
  }

  Future<List<Lead>> getUnsentLeads() async {
    final db = await AppDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'leads',
      where: 'sent = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return Lead.fromMap(maps[i]);
    });
  }

  Future<void> markLeadAsSent(int leadId) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'leads',
      {'sent': 1},
      where: 'id = ?',
      whereArgs: [leadId],
    );
  }
}
