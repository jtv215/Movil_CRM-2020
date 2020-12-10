import 'dart:convert';
import 'dart:io';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:form_validation/src/global/global.dart' as globals;

final _prefs = new PreferenciasUsuario();

class TecnicoSubirFotoProvider {
  Future<String> subirImage(File imagen, tecnico) async {
    print('paso 2');
    final url = Uri.parse('${globals.url}/upload-image-user/${tecnico.id}');

    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    var headers = {
      "Content-type": "application/json",
      "Authorization": _prefs.token.toString()
    };

    final imageUploadRequest = http.MultipartRequest('PUT', url);
    final file = await http.MultipartFile.fromPath('image', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    // if (resp.statusCode != 200 && resp.statusCode != 201) {
    //   print('algo salio mal');
    //   print(resp.body);
    //   return null;
    // }

    final respData = json.decode(resp.body);
    print(resp.body);
    return respData['image'];
  }
}
