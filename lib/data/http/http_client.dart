import 'package:meta/meta.dart';

abstract class HttpClient {
  dynamic request({@required String url, @required String method, Map body});
}
