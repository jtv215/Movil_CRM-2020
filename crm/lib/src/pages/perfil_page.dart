import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validation/src/models/tecnico_model.dart';
import 'package:form_validation/src/providers/avisos_provider.dart';
import 'package:form_validation/src/providers/tecnico_provider.dart';
import 'package:form_validation/src/widgets/menu_widgets.dart';
import 'package:form_validation/src/global/global.dart' as globals;

class PerfilPage extends StatefulWidget {
  @override
  _PefilPageState createState() => _PefilPageState();
}

class _PefilPageState extends State<PerfilPage> {
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>(); //para lanzar snackbar
  final avisoProvider = new AvisosProvider();
  File foto;

  // bool _guardando = false;

  bool aux = false;

  static TecnicoProvider tecnicoProvider = new TecnicoProvider();
  TecnicoModel tecnico = new TecnicoModel();

  bool btnsms = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: MenuWidget(),
        appBar: AppBar(
          title: Text(
            'Mi Perfil',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder(
                future: tecnicoProvider.cargarTecnicoService(),
                builder: (context, snapshot) {
                  tecnico = snapshot.data;
                  if (snapshot.hasData) {
                    return Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          _mostrarFoto(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 3.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  tecnico.nombre + '  ' + tecnico.apellidos,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _textoRich(
                              'Especialidad', tecnico.especialidad.tipoAviso),
                          _textoRich('Nombre Empresa', tecnico.nombreEmpresa),
                          _textoRich('Código Postal', tecnico.cp.toString()),
                          _textoRich(
                              'Provincia', tecnico.provincia.nombre.toString()),
                          _textoRich('Móvil', tecnico.telefono1.toString()),
                          _textoRich('Estado', tecnico.estado.toString()),
                          _textoRich('Numeros de avisos semanales',
                              tecnico.numAvisos.toString()),
                          _textoRich('Nº de Km de desplazamiento',
                              tecnico.kmDesplazamiento.toString()),
                          _textoRich('SMS', tecnico.activarSms),
                          _textoRich('Correo', tecnico.activarCorreo),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: globals.colorVerde,
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, 'perfil_editar', arguments: tecnico);
            }),
      ),
    );
  }

  Widget _textoRich(tipo, valor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.5),
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(
                text: tipo,
                style: TextStyle(color: Colors.black45, fontSize: 15),
                children: <TextSpan>[
              TextSpan(
                text: '  ' + valor,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ])),
      ),
    );
  }

  Widget _mostrarFoto() {
    
       if (tecnico.image == null || tecnico.image == '') {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 180.0,
        );
      }
      return Image.asset(foto?.path ?? 'assets/imagen_cara.jpg');
    }
    
    if (tecnico.image != null) {
      return FadeInImage(
        image:
            NetworkImage('${globals.url}/get-image-tecnico/${tecnico.image}'),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    }

 
  }
}
