import 'package:flutter/material.dart';

class Cita {
  Cita({
    @required this.nombre,
    @required this.fecha,
    @required this.hora,
    @required this.telefono,
    @required this.id,
    this.monto,
    this.medio,
  });
  String id;
  String nombre;
  DateTime fecha;
  String hora;
  String telefono;
  String monto;
  String medio;
}

class ServicioBelleza {
  ServicioBelleza({
    @required this.nombre,
    @required this.descripcion,
    @required this.precio,
    @required this.img,
    @required this.id,
  });
  String nombre;
  String descripcion;
  String precio;
  String img;
  String id;
}
