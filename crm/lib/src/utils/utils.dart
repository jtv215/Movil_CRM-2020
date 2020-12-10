import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text('$mensaje'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

@override
String convetirString(bool value) {
  if (value == true) {
    String aux = 'SI';
    return aux;
  }
  if (value == false) {
    String aux = 'NO';
    return aux;
  }
}

bool convetirBooleano(String v) {
  return (v == 'NO') ? false : true;
}
