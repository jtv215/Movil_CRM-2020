import 'dart:convert';
import 'package:http/http.dart';


import 'package:form_validation/src/models/tecnico_model.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:form_validation/src/global/global.dart' as globals;
import 'interceptor.dart';


final _prefs = new PreferenciasUsuario();
final Client http = HttpClientWithInterceptor.build(interceptors: [
  WeatherApiInterceptor(),
]);

class TecnicoProvider {
  Future<TecnicoModel> cargarTecnicoService() async {
    try {
      final resp = await http.get(
        '${globals.url}/tecnico/${_prefs.id}',
      );

      final Map<String, dynamic> decodedData = json.decode(resp.body);
      // print('paso1:entra');
      print(decodedData['tecnico']);
      final tecnico = TecnicoModel.fromJson(decodedData['tecnico']);

      if (decodedData['tecnico'] == null) return null;
      return tecnico;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<TecnicoModel> actualizarTecnico(TecnicoModel tecnico) async {
    var url = '${globals.url}/tecnico/${tecnico.id}';
    var body = jsonEncode(tecnico);
    try {
      final resp = await http.put(url, body: body);

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      final tecnico = TecnicoModel.fromJson(decodedData['tecnico']);
      if (decodedData['tecnico'] == null) return null;

      return tecnico;
    } catch (e) {
      print(e);
    }
    return null;
  }

}
