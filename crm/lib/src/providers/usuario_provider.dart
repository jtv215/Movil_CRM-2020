import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:form_validation/src/global/global.dart' as global;


final _prefs = new PreferenciasUsuario();

class UsuarioProvider {
  //Devuelve el token
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '${global.url}/login_tecnico';

    var data = {'email': email, 'password': password, 'gethash': true};
    var body = jsonEncode(data);

    var headers = {
      "Content-type": "application/json",
    };

    final resp = await http.post(url, body: body, headers: headers);

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      _prefs.token = decodeResp['token'];
      return {'ok': true, 'token': decodeResp['token']};
    } else {
      return {'ok': false, 'token': decodeResp['message']};
    }
  }
  //Devuelve los datos del usuario
  loginDatos(String email, String password) async {
    final url = '${global.url}/login_tecnico';

    var data = {'email': email, 'password': password, 'gethash': false};
    var body = jsonEncode(data);

    var headers = {
      "Content-type": "application/json",
    };

    try{

    final resp = await http.post(url, body: body, headers: headers);

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp['tecnico']);
    if (decodeResp['tecnico'].containsKey('_id')) {    
      _prefs.id = decodeResp['tecnico']['_id'];
      
    } 
    }catch (e){


    }
  }
}
