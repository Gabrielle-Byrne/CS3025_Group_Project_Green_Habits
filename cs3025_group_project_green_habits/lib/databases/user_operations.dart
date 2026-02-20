// import 'data.dart';
// import '../profile.dart';  

// class UserOperations {
//   late UserOperations userOperations;

//   final dbProvider = DatabaseRepo.instance;

//   createUser(User user) async {
//     final db = await dbProvider.database;
//     db.insert('user', user.toMap());
//     print('user inserted');
//   }

//   updateUser(User user) async {
//     final db = await dbProvider.database;
//     db.update('user', user.toMap(),
//         where: "userId=?", whereArgs: [user.id]);
//   }

//   deleteUser(User user) async {
//     final db = await dbProvider.database;
//     await db.delete('user', where: 'userId=?', whereArgs: [user.id]);
//   }

//   Future<List<User>> getAllUsers() async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db.query('user');
//     List<User> users =
//     allRows.map((user) => User.fromMap(user)).toList();
//     return users;
//   }

//   Future<List<User>> getAllUsersByCategory(Category category) async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db.rawQuery('''
//     SELECT * FROM user 
//     WHERE user.FK_user_category = ${category.id}
//     ''');
//     List<User> users =
//     allRows.map((user) => User.fromMap(user)).toList();
//     return users;
//   }

//   Future<List<User>> searchUsers(String keyword) async {
//     final db = await dbProvider.database;
//     List<Map<String, dynamic>> allRows = await db
//         .query('user', where: 'userName LIKE ?', whereArgs: ['%$keyword%']);
//     List<User> users =
//     allRows.map((user) => User.fromMap(user)).toList();
//     return users;
//   }
// }

// //WHERE name LIKE 'keyword%'
// //--Finds any values that start with "keyword"
// //WHERE name LIKE '%keyword'
// //--Finds any values that end with "keyword"
// //WHERE name LIKE '%keyword%'
// //--Finds any values that have "keyword" in any position