import 'package:flutter/material.dart';

class Cita {
  Cita({
    @required this.nombre,
    @required this.fecha,
    @required this.hora,
    @required this.telefono,
    this.monto,
    this.medio,
  });
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
  });
  String nombre;
  String descripcion;
  String precio;
  String img;
}
