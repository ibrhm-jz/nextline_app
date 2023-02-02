import 'package:nextline_app/data/constants/api_constants.dart';

Uri buildUri(String path, {Map<String, String>? params}) {
  Uri baseUri = Uri.parse(baseUrl);
  if (baseUri.scheme == 'http') {
    return Uri.http(
      baseUri.host,
      path,
      params,
    );
  } else {
    return Uri.https(baseUri.host, path, params);
  }
}
