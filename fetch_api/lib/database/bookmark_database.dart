import 'package:flutter/foundation.dart' show immutable;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bookmarks.dart';

@immutable
class BookmarkDatabase {
  static const String _databaseName = 'tasks.db';
  static const int _databaseVersion = 1;

  // Singleton
  const BookmarkDatabase._privateConstructor();
  static const BookmarkDatabase instance =
      BookmarkDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    // Initialize database if it's not already open
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $bookmarkTable (
        ${BookmarksFields.id} $idType,
        ${BookmarksFields.khanjiId} $intType,
        ${BookmarksFields.khanji} $textType,
        ${BookmarksFields.onyomi} $textType,
        ${BookmarksFields.kunyomi} $textType,
        ${BookmarksFields.meaning} $textType
      )
    ''');
  }

  // CRUD operations
  Future<Bookmarks> createBookmark(Bookmarks bookmark) async {
    final db = await instance.database;
    final id = await db.insert(bookmarkTable, bookmark.toMap());
    return bookmark.copy(id: id);
  }

  Future<Bookmarks> readBookmark(int id) async {
    final db = await instance.database;
    final taskData = await db.query(
      bookmarkTable,
      columns: BookmarksFields.values,
      where: '${BookmarksFields.id} = ?',
      whereArgs: [id],
    );

    if (taskData.isNotEmpty) {
      return Bookmarks.fromMap(taskData.first);
    } else {
      throw Exception('Could not find a task');
    }
  }

  Future<List<Bookmarks>> readAllBookmarks() async {
    final db = await instance.database;
    final result = await db.query(
      bookmarkTable,
      orderBy: '${BookmarksFields.id} DESC',
    );
    return result.map((taskData) => Bookmarks.fromMap(taskData)).toList();
  }

  Future<int> deleteBookmarkByKhanjiId(int khanjiId) async {
    final db = await instance.database;
    return await db.delete(
      bookmarkTable,
      where: '${BookmarksFields.khanjiId} = ?',
      whereArgs: [khanjiId],
    );
  }

  Future<bool> isBookmarked(int khanjiId) async {
    final db = await instance.database;
    final result = await db.query(
      bookmarkTable,
      where: '${BookmarksFields.khanjiId} = ?',
      whereArgs: [khanjiId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<int> deleteBookmark(int id) async {
    final db = await instance.database;
    return await db.delete(
      bookmarkTable,
      where: '${BookmarksFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Close database connection
  Future close() async {
    if (_database != null) {
      await _database!.close();
      _database = null; // Clear the reference
    }
  }
}
