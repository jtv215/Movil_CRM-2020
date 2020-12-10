// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromJson(jsonString);

import 'dart:convert';

// import 'dart:ffi';

AvisoModel avisoModelFromJson(String str) =>
    AvisoModel.fromJson(json.decode(str));

String avisoModelToJson(AvisoModel data) => json.encode(data.toJson());
// const TipoAviso tipoaviso = new TipoAviso("","",0);
class AvisoModel {
  AvisoModel({
    this.id,
    this.idAviso,
    this.tipoAviso,
    this.observacion,
    this.nombreElectrodomestico,
    this.marca,
    this.nombreCliente,
    this.apellidosCliente,
    this.telefono1,
    this.telefono2,
    this.provincia,
    this.cp,
    this.direccion,
    this.finalizado,
    this.pagado,
    this.fechaCreacion,
    this.empleado,
    this.tecnico,
    this.descriptionProblema,
    this.v,
  });

  String id;
  String idAviso;
  TipoAviso tipoAviso;
  String observacion;
  Marca nombreElectrodomestico;
  Marca marca;
  String nombreCliente;
  String apellidosCliente;
  String telefono1;
  String telefono2;
  Marca provincia;
  String cp;
  String direccion;
  String finalizado;
  String pagado;
  String fechaCreacion;
  String empleado;
  String tecnico;
  String descriptionProblema;
  int v;

  factory AvisoModel.fromJson(Map<String, dynamic> json) => AvisoModel(
        id: json["_id"],
        idAviso: json["idAviso"],
        tipoAviso: TipoAviso.fromJson(json["tipoAviso"]),
        observacion: json["observacion"],
        nombreElectrodomestico: Marca.fromJson(json["nombreElectrodomestico"]),
        marca: Marca.fromJson(json["marca"]),
        nombreCliente: json["nombreCliente"],
        apellidosCliente: json["apellidosCliente"],
        telefono1: json["telefono1"],
        telefono2: json["telefono2"],
        provincia: Marca.fromJson(json["provincia"]),
        cp: json["cp"],
        direccion: json["direccion"],
        finalizado: json["finalizado"],
        pagado: json["pagado"],
        fechaCreacion: json["fechaCreacion"],
        empleado: json["empleado"],
        tecnico: json["tecnico"],
        descriptionProblema: json["descriptionProblema"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "idAviso": idAviso,
        "tipoAviso": tipoAviso.toJson(),
        "observacion": observacion,
        "nombreElectrodomestico": nombreElectrodomestico.toJson(),
        "marca": marca.toJson(),
        "nombreCliente": nombreCliente,
        "apellidosCliente": apellidosCliente,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "provincia": provincia.toJson(),
        "cp": cp,
        "direccion": direccion,
        "finalizado": finalizado,
        "pagado": pagado,
        "fechaCreacion": fechaCreacion,
        "empleado": empleado,
        "tecnico": tecnico,
        "descriptionProblema": descriptionProblema,
        "__v": v,
      };
}

class Marca {
  Marca({
    this.id,
    this.nombre,
    this.v,
  });

  String id;
  String nombre;
  int v;

  factory Marca.fromJson(Map<String, dynamic> json) => Marca(
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

class TipoAviso {
  TipoAviso({
    this.id,
    this.tipoAviso,
    this.v,
  });

  String id;
  String tipoAviso;
  int v;

  factory TipoAviso.fromJson(Map<String, dynamic> json) => TipoAviso(
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
