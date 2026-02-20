// import 'dart:io';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';


// class DatabaseRepo {
//   DatabaseRepo.privateConstructor();

//   static final DatabaseRepo instance =
//       DatabaseRepo.privateConstructor();

//   final databaseName = 'greenHabitsDatabase';
//   final databaseVersion = 1;

//   static Database database;

//   Future<Database> get database async {
//     if (database != null) {
//       return database;
//     } else {
//       database = await _initDatabase();
//     }
//   }

//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, databaseName);
//     return await openDatabase(path,
//         version: databaseVersion, onCreate: await onCreate);
//   }

//   Future onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE User (
//             userId INTEGER PRIMARY KEY AUTOINCREMENT,
//             username STRING NOT NULL,
//             email STRING NOT NULL,
//             textSize INTEGER NOT NULL,
//             language STRING NOT NULL,
//             icon STRING NOT NULL,
//             darkModeEnabled BOOELAN NOT NULL,
//             soundEnabled BOOELAN NOT NULL,
//             FK_contact_category INT NOT NULL,
//             FOREIGN KEY (FK_contact_category) REFERENCES category (categoryId) 
//           )
//           ''');
    
//     await db.execute('''
//           CREATE TABLE actions (
//             actionId INTEGER PRIMARY KEY AUTOINCREMENT,
//             name STRING NOT NULL,
//             description STRING NOT NULL,
//             baseScore INTEGER NOT NULL,
//           )
//           ''');

//     await db.execute('''
//           CREATE TABLE UserActions (
//             userActionId INTEGER PRIMARY KEY AUTOINCREMENT,
//             FK_user INT NOT NULL,
//             FK_action_category INT NOT NULL,
//             FOREIGN KEY (FK_user) REFERENCES User (userId)
//             FOREIGN KEY (FK_action_category) REFERENCES Action (actionId)
//           )
//           ''');

//     await db.execute('''
//           CREATE TABLE Plant (
//             plantId INTEGER PRIMARY KEY AUTOINCREMENT,
//             name STRING NOT NULL,
//             FK_user INT NOT NULL,
//             FK_action_category INT NOT NULL,
//             FOREIGN KEY (FK_user) REFERENCES User (userId)
//             FOREIGN KEY (FK_action_category) REFERENCES Action (actionId)
//           )
//           ''');

//     await db.execute('''
//           CREATE TABLE UserPlant (
//             userPlantId INTEGER PRIMARY KEY AUTOINCREMENT,
//             FK_user INT NOT NULL,
//             FK_plant_category INT NOT NULL,
//             plant_state INT NOT NULL
//           )
//           ''');

//     await db.execute('''
//           CREATE TABLE Tips (
//             tipId INTEGER PRIMARY KEY AUTOINCREMENT,
//             description STRING NOT NULL,
//             category STRING NOT NULL
//           )
//           ''');
//   }
// }