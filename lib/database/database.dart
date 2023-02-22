import 'package:mysql_client/mysql_client.dart';

class Database {
  Future<void> databslogin(String username) async {
  print("Connecting to mysql server...");

  // create connection
  final conn = await MySQLConnection.createConnection(
    host: "141.18.15.55",
    port: 3306,
    userName: "root",
    password: "1111",
    databaseName: "pos_db", // optional
  );

  await conn.connect();

  print("Connected");

  // update some rows
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


