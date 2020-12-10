import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/providers/usuario_provider.dart';
import 'package:form_validation/src/utils/utils.dart';
import 'package:form_validation/src/global/global.dart' as globals;

class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Technology-CRM')),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                ('assets/logo.png'),
                height: 130.0,
                width: 150.0,
              ),
              SizedBox(height: 60.0, width: double.infinity),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          SafeArea(
            child: Container(
              height: 120.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                // Text('Ingresar', style: TextStyle(fontSize: 20.0)),
                // SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 20.0),
                _crearPassword(bloc),
                SizedBox(height: 20.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text(
              '¿Olvidó su contraseña?',
              style: TextStyle(fontSize: 20, color: globals.colorVerde),
            ),
            onPressed: () {},
            //Navigator.pushReplacementNamed(context, 'registro'),
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              icon: Icon(Icons.email, color: globals.colorVerde),
              hintText: 'ejemplo.@gmail.com',
              labelText: 'Correo electrónico',
              suffixIcon:
                  Icon(Icons.alternate_email, color: globals.colorVerde),
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                icon: Icon(Icons.vpn_key, color: globals.colorVerde),
                labelText: 'Contraseña',
                //counterText: snapshot.data,
                suffixIcon: Icon(Icons.lock_outline, color: globals.colorVerde),
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('ENTRAR', style: TextStyle(fontSize: 18.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: globals.colorVerde,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    await usuarioProvider.loginDatos(bloc.email, bloc.password);

    print(info);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['token']);
    }
  }
}
