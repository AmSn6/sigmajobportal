import 'package:http/http.dart' as http;

var headers = {'authorization' : 'RRdcXRwfbdOA'};

Future<String> httpPost({String url, Map<String,String> params}) async {
  print('url - $url, params - $params');
  var res = await http.post(Uri.parse(url),headers: headers,body: params);
  print('response - ${res.body}');
  if(res.statusCode == 200){
    return res.body;
  } else {
    return 'Error';
  }
}

Future<String> httpGet({String url}) async {
  print('url - $url');
  var res = await http.get(Uri.parse(url), headers: headers);
  print('response - ${res.body}');
  if(res.statusCode == 200){
    print('response - ${res.body}');

    return res.body;
  } else {
    return 'Error';
  }
}