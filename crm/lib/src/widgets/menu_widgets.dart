import 'package:flutter/material.dart';
import 'package:form_validation/src/global/global.dart' as globals;


class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
      child: ListView(
        padding: EdgeInsets.all(30), //para que empieze desde arriba.
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Text(
              '', 
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.png'), 
          
                    fit: BoxFit.contain)),
          ),
          Text( 'Menu', style: TextStyle(fontSize: 20.0),
           
          ),
          ListTile(
            leading: Icon(Icons.home, color:globals.colorVerde),
            title: Text('Inicio',
            style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),    
          ListTile(
            leading: Icon(Icons.perm_identity, color: globals.colorVerde),
            title: Text('Perfil',
             style: TextStyle(fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'perfil');
            },
          ),    
       
          ListTile(
            leading: Icon(Icons.power_settings_new, color:globals.colorVerde),
            title: Text('Salir', 
             style: TextStyle(fontSize: 20.0),),
            onTap: () {
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context,'login'); //se booran todas las pantallas anterior
              //se suele usar para despues de un login
            },
          ),
        ],
      ),
    )
    );
  }
}