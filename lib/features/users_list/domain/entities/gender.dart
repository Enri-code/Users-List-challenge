class Gender {
  const Gender._(this.id);

  factory Gender.fromValue(String value) {
    return values.firstWhere(
      (e) => value.toLowerCase() == e.id,
      orElse: () => const Gender._('unknown'),
    );
  }

  static const male = Gender._('male');
  static const female = Gender._('female');

  static const values = [male, female];

  final String id;

  @override
  bool operator ==(dynamic other) => other is Gender && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
