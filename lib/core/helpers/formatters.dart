String nameShortener(String name, [int maxLength = 3]) {
  final letters = name.trim().split(' ').map((e) => e[0]);
  return letters.take(maxLength).join().toUpperCase();
}
