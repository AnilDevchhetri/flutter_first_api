class Khanji {
  int? id;
  String? khanji;
  String? slug;
  String? meaning;
  String? strokeImageUrl;

  String? onyomi;
  String? kunyomi;
  int? strokCount;
  String? onyomiWords;
  String? kunyomiWords;
  String? specialWords;
  String? jlptLevel;

  List<Example> examples;

  Khanji({
    this.id,
    this.khanji,
    this.slug,
    this.meaning,
    this.strokeImageUrl,
    this.onyomi,
    this.kunyomi,
    this.strokCount,
    this.onyomiWords,
    this.kunyomiWords,
    this.specialWords,
    this.jlptLevel,
    this.examples = const [],
  });

  Khanji.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        khanji = json['khanji'],
        slug = json['slug'],
        meaning = json['meaning'],
        strokeImageUrl = json['stroke_image_url'],
        onyomi = json['onyomi'],
        kunyomi = json['kunyomi'],
        strokCount = json['stroke_count'],
        onyomiWords = json['onyomi_words'],
        kunyomiWords = json['kunyomi_words'],
        specialWords = json['special_words'],
        jlptLevel = json['jlpt_level'],
        examples = (json['examples'] as List<dynamic>)
            .map((example) => Example.fromJson(example))
            .toList();
}

class Example {
  int? id;
  String? khanjiSentence;
  String? exampleHiragana;
  String? exampleRomaji;
  String? exampleMeaning;

  Example({
    this.id,
    this.khanjiSentence,
    this.exampleHiragana,
    this.exampleRomaji,
    this.exampleMeaning,
  });

  Example.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        khanjiSentence = json['khanji_sentance'],
        exampleHiragana = json['example_hiragana'],
        exampleRomaji = json['example_romaji'],
        exampleMeaning = json['example_meaning'];
}
