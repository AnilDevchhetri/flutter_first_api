import 'package:flutter/foundation.dart' show immutable;

const String bookmarkTable = 'bookmark';

class BookmarksFields {
//use this list to retreving from database
  static final List<String> values = [
    id,
    khanjiId,
    khanji,
    onyomi,
    kunyomi,
    meaning
  ];

  //Column names for the bookmarks
  static const id = 'id';
  static const khanjiId = 'khanjiId';
  static const khanji = 'khanji';
  static const onyomi = 'onyomi';
  static const kunyomi = 'kunyomi';
  static const meaning = 'meaning';
}

@immutable
class Bookmarks {
  final int? id;
  final int? khanjiId;
  final String? khanji;
  final String? onyomi;
  final String? kunyomi;
  final String? meaning;

  const Bookmarks(
      {this.id,
      this.khanjiId,
      this.khanji,
      this.onyomi,
      this.kunyomi,
      this.meaning});

  Bookmarks copy(
          {int? id,
          int? khanjiId,
          String? khanji,
          String? onyomi,
          String? kunyomi,
          String? meaning}) =>
      Bookmarks(
          id: id ?? this.id,
          khanjiId: khanjiId ?? this.khanjiId,
          khanji: khanji ?? this.khanji,
          onyomi: onyomi ?? this.onyomi,
          kunyomi: kunyomi ?? this.kunyomi,
          meaning: meaning ?? this.meaning);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      BookmarksFields.id: id,
      BookmarksFields.khanjiId: khanjiId,
      BookmarksFields.khanji: khanji,
      BookmarksFields.onyomi: onyomi,
      BookmarksFields.kunyomi: kunyomi,
      BookmarksFields.meaning: meaning
    };
  }

  factory Bookmarks.fromMap(Map<String, dynamic> map) {
    return Bookmarks(
        id: map[BookmarksFields.id] != null
            ? map[BookmarksFields.id] as int
            : null,
        khanjiId: map[BookmarksFields.khanjiId] as int,
        khanji: map[BookmarksFields.khanji] as String,
        onyomi: map[BookmarksFields.onyomi] as String,
        kunyomi: map[BookmarksFields.kunyomi] as String,
        meaning: map[BookmarksFields.meaning] as String);
  }
}
