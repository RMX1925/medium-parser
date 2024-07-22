class ResponseBody {
  final String response;
  final int statusCode;
  bool disableJavascript;

  ResponseBody({
    required this.response,
    required this.statusCode,
    this.disableJavascript = false,
  });
}
