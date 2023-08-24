class ResponseModel {
  String _message;
  bool _isSuccess;

  ResponseModel(this._message, this._isSuccess);

  ResponseModel.withSuccess([String? message, int? code])
      : _message = message ?? '',
        _isSuccess = true;

  ResponseModel.withError([String? message, int? code])
      : _message = message ?? '',
        _isSuccess = false;

  bool get isSuccess => _isSuccess;

  String get message => _message;
}
