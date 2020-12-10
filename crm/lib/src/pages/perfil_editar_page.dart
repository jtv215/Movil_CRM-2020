import 'dart:io';

import 'package:flutter/material.dart';

import 'package:form_validation/src/models/tecnico_model.dart';
import 'package:form_validation/src/providers/subirFoto_provider.dart';
import 'package:form_validation/src/providers/tecnico_provider.dart';
import 'package:form_validation/src/global/global.dart' as globals;
import 'package:form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class PerfilEditarPage extends StatefulWidget {
  @override
  _PefilEditarPageState createState() => _PefilEditarPageState();
}

class _PefilEditarPageState extends State<PerfilEditarPage> {
  final formkey2 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>(); //para lanzar snackbar
  bool _guardando = false;

  final tecnicoProvider = new TecnicoProvider();
    final tecnicosubirFoto = new TecnicoSubirFotoProvider();


  TecnicoModel tecnico = new TecnicoModel();
  bool smsBool = false;
  bool correoBool = false;
  File foto;
  @override
  Widget build(BuildContext context) {
    final TecnicoModel tecnicoData = ModalRoute.of(context).settings.arguments;

    if (tecnicoData != null) {
      tecnico = tecnicoData;
      // aux= utils.convetirBooleano(tecnico.activarSms);
    }

    return Scaffold(
      key: scaffoldKey,
      // drawer: MenuWidget(),
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),      
      body: SingleChildScrollView(
        child: Container(
         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
         
          child: Form(
            
            key: formkey2,
            child: Column(
              
              children: <Widget>[
                 _mostrarFoto(),
                 SizedBox(
                  height: 10.0,
                ),
                _nombreCliente(),
                SizedBox(
                  height: 10.0,
                ),
                _apellidos(),
                SizedBox(
                  height: 10.0,
                ),
                // _especialidad(),
                _cp(),
                SizedBox(
                  height: 10.0,
                ),
                //_provincia(),
                _email(),
                SizedBox(
                  height: 10.0,
                ),
                // _password(),
                _telefono1(),
                 SizedBox(
                  height: 10.0,
                ),
                _telefono2(),
                 SizedBox(
                  height: 10.0,
                ),
                _nombreEmpresa(),
                 SizedBox(
                  height: 10.0,
                ),
                _numAvisos(),
                 SizedBox(
                  height: 10.0,
                ),
                _kmDesplazamiento(),
                 SizedBox(
                  height: 10.0,
                ),
                
                _activarCorreo(),
                _activarSMS(),
                _crearBoton(tecnico),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreCliente() {
    return TextFormField(
      initialValue: tecnico.nombre,
      textCapitalization: TextCapitalization.sentences,
      
      decoration: InputDecoration(
      
        labelText: 'Nombre',  
        border: OutlineInputBorder(), 
       ),
        onSaved: (String value) {
        tecnico.nombre = value;
      },
    );
  }

  Widget _apellidos() {
    return TextFormField(
      initialValue: tecnico.apellidos,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellidos',  border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.apellidos = value;
      }),
    );
  }

  // Widget _especialidad() {
  //   return TextFormField(
  //     enabled: false,
  //     initialValue: tecnico.especialidad.tipoAviso,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(labelText: 'Especialidad'),
  //   );
  // }

  Widget _cp() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: tecnico.cp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'código Postal',  border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.cp = value;
      }),
    );
  }

    // Widget _provincia() {
   // return TextFormField(
  //    initialValue: tecnico.provincia,
    //  textCapitalization: TextCapitalization.sentences,
      //decoration: InputDecoration(labelText: 'Nombre Empresa'),
      //onSaved: (value) => setState(() {
        //tecnico.provincia = value;
      //}),
    //);
 // }

  Widget _email() {
    return TextFormField(
      enabled: false,
      initialValue: tecnico.email,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Email',  border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.email = value;
      }),
    );
  }

  // Widget _password() {
  //   return TextFormField(
  //     enabled: false,
  //     initialValue: tecnico.password,
  //     textCapitalization: TextCapitalization.sentences,
  //     decoration: InputDecoration(labelText: 'password'),
  //     onSaved: (value) => setState(() {
  //       tecnico.password = value;
  //     }),
  //   );
  // }

  Widget _telefono1() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: tecnico.telefono1,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'telefono', border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.telefono1 = value;
      }),
    );
  }

  Widget _telefono2() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: tecnico.telefono2,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Telefono 2',  border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.telefono2 = value;
      }),
    );
  }

  Widget _nombreEmpresa() {
    return TextFormField(
      initialValue: tecnico.nombreEmpresa,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Empresa',  border: OutlineInputBorder(),),
      onSaved: (value) => setState(() {
        tecnico.nombreEmpresa = value;
      }),
    );
  }

  Widget _numAvisos() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: tecnico.numAvisos.toString(),
      textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
        labelText: 'Nº de avisos semanales', 
        border: OutlineInputBorder(),
        
      ),
      onSaved: (value) => setState(() {
        tecnico.numAvisos = int.parse((value));
      }),
    );
  }



  Widget _activarCorreo() {
    correoBool = utils.convetirBooleano(tecnico.activarCorreo);
    return SwitchListTile(
        value: correoBool,
        title: Text('Activar Correo'),
        activeColor: globals.colorVerde,
        onChanged: (value) => setState(() {
              correoBool = value;
              tecnico.activarCorreo = utils.convetirString(correoBool);
            }));
  }

  Widget _activarSMS() {
    smsBool = utils.convetirBooleano(tecnico.activarSms);
    return SwitchListTile(
        value: smsBool,
        title: Text('sms'),
        activeColor: globals.colorVerde,
        onChanged: (value) => setState(() {
              smsBool = value;
              tecnico.activarSms = utils.convetirString(smsBool);
            }));
  }

  Widget _kmDesplazamiento() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: tecnico.kmDesplazamiento,
      textCapitalization: TextCapitalization.sentences,
      
      decoration: InputDecoration(
        labelText: 'Nº de Kms de Desplazamientos', 
        border: OutlineInputBorder(),
        
      ),
      onSaved: (value) => setState(() {
        tecnico.kmDesplazamiento = (value);
      }),
    );
  }

  Widget _crearBoton(tecnico) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
        child: Text('Actualizar', style: TextStyle(fontSize: 18.0)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: globals.colorVerde,
      textColor: Colors.white,    
      onPressed:
          (_guardando) ? null : _submit, //bloquear el bton despues de guardar
    );
  }

  void _submit() async {
    if (!formkey2.currentState.validate()) return;

    formkey2.currentState.save();
    setState(() {
      _guardando = true;
    });

        print('PASO 1');

      print(foto);
     if(foto!=null){
     tecnico.image=  await tecnicosubirFoto.subirImage(foto,tecnico);
    }

    tecnicoProvider.actualizarTecnico(tecnico);
    mostrarSnackbar('Se ha actualizado correctamente');
    Navigator.pushNamed(context, 'perfil');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(
          seconds: 3,
        ));

    scaffoldKey.currentState.showSnackBar(snackbar);
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

  _seleccionarFoto() async {
       _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);

    if(pickedFile ==null){
    }else{
    foto = File(pickedFile.path);
    }

    // foto = File(pickedFile.path);
    setState(() {});
    //cuando se cambiar la image por otra
    if (foto != null) {
      tecnico.image=null;

    }
  }
}
