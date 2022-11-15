class SectionType {
  const SectionType._(this._id);

  static const active = SectionType._('active');
  static const inactive = SectionType._('inactive');

  final String _id;

  String get title => '${_id[0].toUpperCase()}${_id.substring(1)}';

  @override
  bool operator ==(dynamic other) {
    if (other is String) return other == _id;
    return other is SectionType && other._id == _id;
  }

  @override
  int get hashCode => _id.hashCode;
}
