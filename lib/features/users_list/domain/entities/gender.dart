class Gender {
  const Gender._(this.id);
  factory Gender.fromValue(String value) {
    if (value == male.id) return male;
    return female;
  }

  static const male = Gender._('male');
  static const female = Gender._('female');

  final String id;

  @override
  bool operator ==(dynamic other) => other is Gender && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
