import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http_interceptor/http_interceptor.dart';

class WeatherApiInterceptor implements InterceptorContract {
  final _prefs = new PreferenciasUsuario();

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Authorization"] = _prefs.token.toString();
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}
