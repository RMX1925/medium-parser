import 'package:hive/hive.dart';
part 'response_modal.g.dart';

@HiveType(typeId: 0)
class ResponseBody extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String response;

  @HiveField(2)
  final int statusCode;

  @HiveField(3)
  bool disableJavascript;

  @HiveField(4)
  String title;

  @HiveField(5)
  String url;

  ResponseBody({
    this.title = "",
    this.url = "",
    this.id = "",
    required this.response,
    required this.statusCode,
    this.disableJavascript = false,
  });
}
