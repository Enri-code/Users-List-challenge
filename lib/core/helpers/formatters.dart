String nameShortener(String name, [int maxLength = 3]) {
  final letters = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '');
  return letters.take(maxLength).join().toUpperCase();
}
