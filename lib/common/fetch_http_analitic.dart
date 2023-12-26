import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:webfeed/webfeed.dart';

fetchHttpAnalitic(uri) {
  var client = http.Client();
  return client.get(uri);
}

parseDescription(description) {
  description = parse(description);
  var parseDescription = parse(description.body.text).documentElement;
  if (parseDescription != null) {
    var txtDescription = parseDescription.text;
    return txtDescription;
  }
  return Null;
}
