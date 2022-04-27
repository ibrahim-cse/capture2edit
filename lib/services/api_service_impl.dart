import 'dart:convert';

import 'package:capture2edit/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServiceImpl {
  final String _baseURl = 'https://www.akif.com';

  Future<bool> doSigning(UserModel data) async {
    bool result = false;
    //ToDo: Write code.
    String url = _baseURl + 'DoSigning';
    Map body = {
      'token': '1234',
      'data': data,
    };
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var dataJson = await json.decode(response.body);
    result = dataJson['isSuccess'];

    return result;
  }
}
