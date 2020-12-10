import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_validation/src/global/global.dart' as globals;
import 'package:form_validation/src/models/aviso_model.dart';
import 'package:form_validation/src/providers/avisos_provider.dart';
import 'package:form_validation/src/widgets/menu_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final avisoProvider = new AvisosProvider();
  final _debouncer = Debouncer(milliseconds: 500);
  List<AvisoModel> avisosLista = List();
  List<AvisoModel> filteredAvisos = List();

  @override
  void initState() {
    super.initState();
    cargarAvisosServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuWidget(),
        appBar: AppBar(
          title: Text('Technology-CRM'),
          actions: <Widget>[],
        ),
        body: Column(children: <Widget>[
          _buscador(),
          _crearListado(),
        ]));
  }

  Widget _buscador() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(),
        hoverColor: globals.colorVerdeSuave,
        hintText: 'Buscar... ',
      ),
      onChanged: (string) {
        _debouncer.run(() {
          setState(() {
            filteredAvisos = avisosLista
                .where((u) => (u.idAviso
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                    u.fechaCreacion
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                    u.nombreCliente
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                    u.telefono1.toLowerCase().contains(string.toLowerCase()) ||
                    u.telefono2.toLowerCase().contains(string.toLowerCase()) ||
                    u.tipoAviso.tipoAviso
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                    u.direccion.toLowerCase().contains(string.toLowerCase())))
                .toList();
          });
        });
      },
    );
  }

  Widget _crearListado() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refrescarLista,
        child: ListView.builder(
          itemCount: filteredAvisos.length,
          itemBuilder: (context, index) =>
              _crearItem(context, filteredAvisos[index]),
        ),
      ),
    );
  }

  Widget _crearItem(BuildContext context, AvisoModel aviso) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${aviso.idAviso} - ${aviso.fechaCreacion}'),
            subtitle: Text('Asunto: '
                '${aviso.descriptionProblema} '
                ' en '
                '${aviso.direccion} '
                'Cliente : '
                ' ${aviso.nombreCliente} - ${aviso.telefono1}'),
            leading: Icon(
                (aviso.finalizado == 'SI')
                    ? Icons.check_circle_outline
                    : Icons.add_alert,
                size: 45.0,
                color: (aviso.finalizado == 'SI')
                    ? Theme.of(context).primaryColor
                    : Colors.yellow[300]),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: globals.colorVerde,
            ),
            onTap: () => Navigator.pushNamed(context, "aviso", arguments: aviso)
                .then((value) => setState(() {})),
          ),
        ],
      ),
    );
  }

  void cargarAvisosServices() async {
    avisoProvider.cargarAvisos().then((avisosFromServer) {
      setState(() {
        avisosLista = avisosFromServer;
        filteredAvisos = avisosLista;
      });
    });
  }

  Future<Null> refrescarLista() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      avisoProvider.cargarAvisos().then((avisosFromServer) {
        setState(() {
          avisosLista = avisosFromServer;
          filteredAvisos = avisosLista;
        });
      });
    });

    return Future.delayed(duration);
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
