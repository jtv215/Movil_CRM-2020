import 'dart:convert';
import 'interceptor.dart';

import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:form_validation/src/models/aviso_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:form_validation/src/global/global.dart' as globals;

final _prefs = new PreferenciasUsuario();
final Client http = HttpClientWithInterceptor.build(interceptors: [
  WeatherApiInterceptor(),
]);

class AvisosProvider {
  Future<List<AvisoModel>> cargarAvisos() async {
    final List<AvisoModel> avisos = new List();
    try {
      final resp = await http.get('${globals.url}avisos_tecnico/${_prefs.id}');
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData == null) return [];

      for (var item in decodedData['avisos']) {
        final aviso = AvisoModel.fromJson(item);
        avisos.add(aviso);
      }
    } catch (e) {}
    return avisos;
  }

  Future<List<AvisoModel>> actualizarAviso(AvisoModel aviso) async {
    final List<AvisoModel> avisos = new List();

    try {
      final resp = await http.put(
        '${globals.url}/aviso/${aviso.id}',
        body: jsonEncode(aviso),
      );

      final Map<String, dynamic> decodedData = json.decode(resp.body);

      for (var item in decodedData['avisos']) {
        final aviso = AvisoModel.fromJson(item);
        avisos.add(aviso);
      }
    } catch (e) {
      print(e);
    }
    return avisos;
  }
}
