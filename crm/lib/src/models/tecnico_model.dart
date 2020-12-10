// To parse this JSON data, do
//
//     final tecnicoModel = tecnicoModelFromJson(jsonString);

import 'dart:convert';


TecnicoModel tecnicoModelFromJson(String str) => TecnicoModel.fromJson(json.decode(str));

String tecnicoModelToJson(TecnicoModel data) => json.encode(data.toJson());

class TecnicoModel {
    TecnicoModel({
        this.id,
        this.nombre='',
        this.apellidos='',
        this.especialidad,
        this.cp='',
        this.email='',
        this.password='',
        this.fechaCreacion='',
        this.image='',
        this.estado='',
        this.telefono1='',
        this.telefono2='',
        this.nombreEmpresa='',
        this.provincia,
        this.numAvisos=0,
        this.v=0,
        this.activarCorreo='',
        this.activarSms='',
        this.kmDesplazamiento='',
        this.km='',
        this.prioridad='',
        this.contador=0,
    });

    String id;
    String nombre;
    String apellidos;
    Especialidad especialidad;
    String cp;
    String email;
    String password;
    String fechaCreacion;
    String image;
    String estado;
    String telefono1;
    String telefono2;
    String nombreEmpresa;
    Provincia provincia;
    int numAvisos;
    int v;
    String activarCorreo;
    String activarSms;
    String kmDesplazamiento;
    String km;
    String prioridad;
    int contador;

    factory TecnicoModel.fromJson(Map<String, dynamic> json) => TecnicoModel(
        id: json["_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        especialidad: Especialidad.fromJson(json["especialidad"]),
        cp: json["cp"],
        email: json["email"],
        password: json["password"],
        fechaCreacion: json["fechaCreacion"],
        image: json["image"],
        estado: json["estado"],
        telefono1: json["telefono1"],
        telefono2: json["telefono2"],
        nombreEmpresa: json["nombreEmpresa"],
        provincia: Provincia.fromJson(json["provincia"]),
        numAvisos: json["numAvisos"],
        v: json["__v"],
        activarCorreo: json["activarCorreo"],
        activarSms: json["activarSMS"],
        kmDesplazamiento: json["kmDesplazamiento"],
        km: json["km"],
        prioridad: json["prioridad"],
        contador: json["contador"],
    );

    //   factory TecnicoModel.fromFuture(Future<TecnicoProvider> json) => TecnicoModel(
    //     id: json["_id"],
    //     nombre: json["nombre"],
    //     apellidos: json["apellidos"],
    //     especialidad: Especialidad.fromJson(json["especialidad"]),
    //     cp: json["cp"],
    //     email: json["email"],
    //     password: json["password"],
    //     fechaCreacion: json["fechaCreacion"],
    //     image: json["image"],
    //     estado: json["estado"],
    //     telefono1: json["telefono1"],
    //     telefono2: json["telefono2"],
    //     nombreEmpresa: json["nombreEmpresa"],
    //     provincia: Provincia.fromJson(json["provincia"]),
    //     numAvisos: json["numAvisos"],
    //     v: json["__v"],
    //     activarCorreo: json["activarCorreo"],
    //     activarSms: json["activarSMS"],
    //     kmDesplazamiento: json["kmDesplazamiento"],
    //     km: json["km"],
    //     prioridad: json["prioridad"],
    //     contador: json["contador"],
    // );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "especialidad": especialidad.toJson(),
        "cp": cp,
        "email": email,
        "password": password,
        "fechaCreacion": fechaCreacion,
        "image": image,
        "estado": estado,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "nombreEmpresa": nombreEmpresa,
        "provincia": provincia.toJson(),
        "numAvisos": numAvisos,
        "__v": v,
        "activarCorreo": activarCorreo,
        "activarSMS": activarSms,
        "kmDesplazamiento": kmDesplazamiento,
        "km": km,
        "prioridad": prioridad,
        "contador": contador,
    };
}

class Especialidad {
    Especialidad({
        this.id,
        this.tipoAviso,
        this.v,
    });

    String id;
    String tipoAviso;
    int v;

    factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        id: json["_id"],
        tipoAviso: json["tipoAviso"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "tipoAviso": tipoAviso,
        "__v": v,
    };
}

class Provincia {
    Provincia({
        this.id,
        this.nombre,
        this.v,
    });

    String id;
    String nombre;
    int v;

    factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
        id: json["_id"],
        nombre: json["nombre"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "__v": v,
    };
}
