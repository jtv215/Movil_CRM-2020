import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validation/src/models/aviso_model.dart';
import 'package:form_validation/src/providers/avisos_provider.dart';
import 'package:form_validation/src/global/global.dart' as globals;

class AvisoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<AvisoPage> {
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>(); //para lanzar snackbar
  final avisoProvider = new AvisosProvider();
  bool _guardando = false;
  File foto;
  AvisoModel aviso = new AvisoModel();
  bool aux = false;

  @override
  Widget build(BuildContext context) {
    final AvisoModel avisoData = ModalRoute.of(context).settings.arguments;

    if (avisoData != null) {
      aviso = avisoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Aviso'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                _tipoAveria(),
                SizedBox(
                  height: 10.0,
                ),
                _descipcion(),
                SizedBox(
                  height: 10.0,
                ),
                _electrodomestico(),
                SizedBox(
                  height: 10.0,
                ),
                _marca(),
                SizedBox(
                  height: 10.0,
                ),
                
                _provincia(),
                SizedBox(
                  height: 10.0,
                ),
                _cp(),
                SizedBox(
                  height: 10.0,
                ),
                _direccion(),
                SizedBox(
                  height: 10.0,
                ),
                _nombreCliente(),
                SizedBox(
                  height: 10.0,
                ),
                _telefono1(),
                SizedBox(
                  height: 10.0,
                ),
                _telefono2(),
                SizedBox(
                  height: 10.0,
                ),
                _observaciones(),
                SizedBox(
                  height: 10.0,
                ),
                _crearDisponible(),
                SizedBox(
                  height: 10.0,
                ),
                _pagado(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tipoAveria() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.tipoAviso.tipoAviso,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo Averia',  border: OutlineInputBorder(),),
    );
  }

  Widget _electrodomestico() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.nombreElectrodomestico.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Electrodoméstico',  border: OutlineInputBorder(),),
    );
  }

  Widget _marca() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.marca.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Marca',  border: OutlineInputBorder(),),
    );
  }

  Widget _provincia() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.provincia.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Provincia',  border: OutlineInputBorder(),),
    );
  }

  Widget _cp() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.cp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Código Postal',  border: OutlineInputBorder(),),
    );
  }

  Widget _direccion() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.direccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Dirección',  border: OutlineInputBorder(),),
    );
  }

  Widget _nombreCliente() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.nombreCliente,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre del cliente',  border: OutlineInputBorder(),),
    );
  }

  Widget _telefono1() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.telefono1,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono 1',  border: OutlineInputBorder(),),
    );
  }

  Widget _telefono2() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.telefono2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono 2',  border: OutlineInputBorder(),),
    );
  }


  Widget _descipcion() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.descriptionProblema,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Asunto',  border: OutlineInputBorder(),),
    );
  }


  Widget _observaciones() {
    return TextFormField(
      enabled: false,
      initialValue: aviso.observacion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Observaciones',  border: OutlineInputBorder(),),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: globals.colorVerde,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed:
          (_guardando) ? null : _submit, //bloquear el bton despues de guardar
    );
  }

  Widget _crearDisponible() {
    if (aviso.finalizado == 'NO') {
      aux = false;
    } else {
      aux = true;
    }

    return SwitchListTile(
        value: aux,
        title: Text('Terminado'),
        activeColor: globals.colorVerde,
        onChanged: (value) => setState(() {
              aux = value;
              if (value == true) {
                aviso.finalizado = "SI";
              } else {
                aviso.finalizado = "NO";
              }
            }));
  }

  Widget _pagado() {
    if (aviso.pagado == 'NO') {
      aux = false;
    } else {
      aux = true;
    }

    return SwitchListTile(
      value: aux,
      title: Text('pagado'),
      activeColor: globals.colorVerde,
      onChanged: null
      );
    
  }

  void _submit() async {
    if (!formkey.currentState.validate()) return;

    formkey.currentState.save();
    setState(() {
      _guardando = true;
    });

    avisoProvider.actualizarAviso(aviso);

    mostrarSnackbar('Se ha actualizado correctamente');
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(
          seconds: 3,
        ));

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
