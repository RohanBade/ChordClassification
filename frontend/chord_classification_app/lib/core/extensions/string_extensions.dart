import 'dart:convert';

extension Stringx on String {
  String get emoji => _emojiDecoder(this);
    String get lastwords => _extractLastTwoWords(this);
}

String _emojiDecoder(String text) {
  String data = '';
  try {
    List<int> bytes = text.codeUnits;
    data = utf8.decode(bytes);
  } catch (e) {
    data = text;
  }
  return data;
}

String _extractLastTwoWords(String filename) {
  List<String> words = filename.split(' ');
  if (words.length < 2) {
    return filename;
  }

  String lastTwoWords = words.sublist(words.length - 1).join(' ');

  return lastTwoWords.emoji;
}