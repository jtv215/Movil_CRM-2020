import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/pages/home_page.dart';
import 'package:form_validation/src/pages/login_page.dart';
import 'package:form_validation/src/pages/aviso_page.dart';
import 'package:form_validation/src/pages/perfil_editar_page.dart';
import 'package:form_validation/src/pages/perfil_page.dart';
import 'package:form_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:form_validation/src/global/global.dart' as globals;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //hay que ponerlo pq da error en  SharedPreferences.getInstance();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Technology-CRM',
          initialRoute: 'perfil',
          routes: {
            'login': (BuildContext context) => LoginPage(),
            'home': (BuildContext context) => HomePage(),
            'aviso': (BuildContext context) => AvisoPage(),
            'perfil': (BuildContext context) => PerfilPage(),
            'perfil_editar': (BuildContext context) => PerfilEditarPage(),
          },
          theme: ThemeData(
            primaryColor: globals.colorVerde,
          )),
    );
  }
}
