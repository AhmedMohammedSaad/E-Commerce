class ErrorModel {
  final String code, message, details, hint;

  ErrorModel({
    required this.code,
    required this.message,
    required this.details,
    required this.hint,
  });
  factory ErrorModel.fromJsom(Map<String, dynamic> jsonData) {
    return ErrorModel(
      code: jsonData['code'],
      message: jsonData['message'],
      details: jsonData['details'],
      hint: jsonData['hint'],
    );
  }
}
