import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class SqliteDayTime {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'daytime.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }

  FutureOr<void> _onCreate(Database db, int version) {
    String sql = '''
  CREATE TABLE daytimeTable(
    No INTEGER PRIMARY KEY AUTOINCREMENT,
    Thedaytime DATETIME,
    Timelist TEXT,
    CheckYn INTEGER
    )
  ''';

    db.execute(sql);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute('ALTER TABLE daytimeTable ADD COLUMN CheckYn INTEGER');
    }
  }

  Future<void> timeInsert(DaytimeModel item) async {
    var db = await database;

    await db.insert(
        'daytimeTable',
        item.toMap()
    );
  }

  Future<List<DaytimeModel>> timeSelect() async {
    var db = await database;

    // testTable 테이블에 있는 모든 field 값을 maps에 저장한다.
    final List<Map<String, dynamic>> maps = await db.query('daytimeTable');

    return List.generate(maps.length, (index) {
      return DaytimeModel(
        No: maps[index]['No'] as int,
        Thedaytime: maps[index]['Thedaytime'] as String,
        Timelist: maps[index]['Timelist'] as String,
        CheckYn: maps[index]['CheckYn'] as int?,
      );
    });
  }

  Future<void> timeDelete(int no) async {
    var db = await database;

    await db.delete(
        'daytimeTable',
        where: 'No = ?',
        whereArgs: [no],
    );
  }
}

class DaytimeModel {
  final int? No;
  final String? Thedaytime;
  final String? Timelist;
  final int? CheckYn;

  DaytimeModel({
    this.No,
    this.Thedaytime,
    this.Timelist,
    this.CheckYn,
  });

  Map<String, dynamic> toMap() => {
    'Thedaytime': Thedaytime,
    'Timelist': Timelist,
    'CheckYn': CheckYn,
  };
}

class Event {
  final int iteration;
  final String startDateTime;
  final String sec_all ;
  final int? checkYn ;
  Event({
    required this.iteration,
    required this.startDateTime,
    required this.sec_all,
    required this.checkYn,
  });
}

