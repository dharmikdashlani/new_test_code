import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../src/product.dart';

class quoteHelper {
  quoteHelper._();

  static final quoteHelper quote_helper = quoteHelper._();
  Database? db;
  int ko =0;

  Future<void> initDb() async {
    String data = await getDatabasesPath();
    String path = join(data, 'quote.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String q =
            "Create TABLE IF NOT EXISTS Quoat(id INTEGER AUTO_INCREMENT PRIMARY KEY, Content TEXT, mood TEXT)";
        await db.execute(q);
      },
    );
  }

  Future<void> insertdb({required String con, required String mood}) async {
    await initDb();

    String q = "INSERT into Quoat(Content,mood) VALUES(?,?)";
    List k =[con,mood];
    await db!.rawInsert(q,k);
  }

  InsertData() {
   Qdatanb.forEach((element) async {
     await insertdb(con: element['content'], mood: element['mood']);
   });
  }

  Future<List<Map<String, Object?>>> SelectAll({required String mood}) async {
    await initDb();
    String q = "Select * from Quoat where mood = ?";
    List k1 = [mood];
    List<Map<String, Object?>> k = await db!.rawQuery(q,k1);
    ko = k.length;
    print(ko);
    return k;

  }
}
