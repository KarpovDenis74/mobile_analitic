import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:webfeed/webfeed.dart';

fetchHttpAnalitic(uri) {
  var client = http.Client();
  return client.get(uri);
}

// parseDescription(description){
//   description = parse(description);
//   var txtDescription = parse(description.body.text).documentElement.text;
//   return txtDescription;
// }