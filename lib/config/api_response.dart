class ApiResponse<T> {
  final String message;
  final int statusCode;
  final T data;

  ApiResponse({required this.message, required this.statusCode, required this.data});
  
}