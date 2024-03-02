/// General model of a failure
abstract class FailureAbstract {
  final dynamic type;
  final String description;
  final dynamic errorCode;

  String toString();

  FailureAbstract(this.type, this.description, this.errorCode);
}

class Failure implements FailureAbstract {
  late String _description;
  dynamic _type;
  dynamic _errorCode;

  @override
  Failure(type, description, errorCode) {
    _description = description ?? "";
    _type = type;
    _errorCode = errorCode;
  }

  @override
  String get description => _description;

  @override
  String toString() {
    return _description;
  }

  @override
  get type => _type;

  get errorCode => _errorCode;
}
