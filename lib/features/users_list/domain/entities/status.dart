class Status {
  const Status._(this._id);

  factory Status.fromValue(String value) {
    if (value == active._id) return active;
    return inactive;
  }

  static const active = Status._('active');
  static const inactive = Status._('inactive');

  final String _id;

  String get title => '${_id[0].toUpperCase()}${_id.substring(1)}';

  @override
  bool operator ==(dynamic other) {
    if (other is String) return other == _id;
    return other is Status && other._id == _id;
  }

  @override
  int get hashCode => _id.hashCode;
}
