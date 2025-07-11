int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTIme = wordCount / 225;
  return readingTIme.ceil();
}
