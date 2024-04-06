import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Define o caminho para o banco de dados.
    String dbPath = join(await getDatabasesPath(), 'app_database.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        // Cria a tabela 'leads' quando o banco de dados é criado pela primeira vez.
        await db.execute(
          "CREATE TABLE leads(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phone TEXT, carId INTEGER, sent INTEGER)",
        );
      },
    );

    return _database!;
  }
}
