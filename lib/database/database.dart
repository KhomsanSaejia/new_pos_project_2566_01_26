import 'package:mysql_client/mysql_client.dart';

class Database {
  Future<void> databslogin(String username) async {

  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "innoligent1.ddns.net",
    port: 24002,
    userName: "innoligent_au",
    password: "1111",
    databaseName: "pos_db", // optional
  );

  await conn.connect();
  var result = await conn.execute("SELEC * FROM user WHERE user_username = :username",{"username": username},);


  // print some result data
  print(result.numOfColumns);
  print(result.numOfRows);
  print(result.lastInsertID);
  print(result.affectedRows);

  // print query result
  for (final row in result.rows) {
    // print(row.colAt(0));
    // print(row.colByName("title"));

    // print all rows as Map<String, String>
    print(row.assoc());
  }

  // close all connections
  await conn.close();
}

  Database();
}


