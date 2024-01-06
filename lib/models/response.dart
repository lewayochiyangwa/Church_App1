class LoginResponse {
  final String status;
  final int code;
  final String message;
  final List<int> data;

  LoginResponse({required this.status, required this.code, required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: List<int>.from(json['data']),
    );
  }
}