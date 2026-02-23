// import 'data.dart';
// import '../profile.dart';  

// class UserPlantOperations {
//   late UserPlantOperations userPlantOperations;

//   final dbProvider = DatabaseRepo.instance;

//   createUserPlant(UserPlant userPlant) async {
//     final db = await dbProvider.database;
//     db.insert('userPlant', userPlant.toMap());
//     print('userPlant inserted');
//   }

//   updateUserPlant(UserPlant userPlant) async {
//     final db = await dbProvider.database;
//     db.update('userPlant', userPlant.toMap(),
//         where: "userPlantId=?", whereArgs: [userPlant.id]);
//   }

//   deleteUserPlant(UserPlant userPlant) async {
//     final db = await dbProvider.database;
//     await db.delete('userPlant', where: 'userPlantId=?', whereArgs: [userPlant.id]);
//   }

//   Future<List<UserPlant>> getAllUserPlants() async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db.query('userPlant');
//     List<UserPlant> userPlants =
//     allRows.map((userPlant) => UserPlant.fromMap(userPlant)).toList();
//     return userPlants;
//   }

//   Future<List<UserPlant>> getAllUserPlantsByCategory(Category category) async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db.rawQuery('''
//     SELECT * FROM userPlant 
//     WHERE userPlant.FK_userPlant_category = ${category.id}
//     ''');
//     List<UserPlant> userPlants =
//     allRows.map((userPlant) => UserPlant.fromMap(userPlant)).toList();
//     return userPlants;
//   }

//   Future<List<UserPlant>> searchUserPlants(String keyword) async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db
//         .query('userPlant', where: 'userPlantName LIKE ?', whereArgs: ['%$keyword%']);
//     List<UserPlant> userPlants =
//     allRows.map((userPlant) => UserPlant.fromMap(userPlant)).toList();
//     return userPlants;
//   }
// }

// //WHERE name LIKE 'keyword%'
// //--Finds any values that start with "keyword"
// //WHERE name LIKE '%keyword'
// //--Finds any values that end with "keyword"
// //WHERE name LIKE '%keyword%'
// //--Finds any values that have "keyword" in any position