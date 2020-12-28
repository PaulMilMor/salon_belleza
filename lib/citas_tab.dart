import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//
import 'models.dart';
import 'nueva_cita.dart';
import 'pago_dialog.dart';

class CitasTab extends StatefulWidget {
  @override
  _CitasTabState createState() => _CitasTabState();
}

class _CitasTabState extends State<CitasTab> {
  List<Cita> _citas = [
    Cita(
      nombre: 'Juan',
      fecha: DateTime.utc(2020, 12, 31),
      hora: '10:30',
      telefono: '6623642724',
    ),
    Cita(
      nombre: 'José Paúl Millanes Morimoto',
      fecha: DateTime.utc(2020, 12, 25),
      hora: '17:40',
      telefono: '6622334455',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //return _InfoCita(cita: _citas[0]);

    //INTENTO 2

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (_, int index) => _crearListaCita()[index],
        itemCount: _crearListaCita().length,
      ),
    );

    //INTENTO 1

    /*return Scaffold(
      body: Flexible(
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemBuilder: (_, int index) => _crearListaCita()[index],
          itemCount: _crearListaCita().length,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: FloatingActionButton(
          onPressed: () {
            _nuevaCita(context);
          },
          tooltip: 'Nueva Cita',
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF833995),
        ),
      ),
    );*/
  }

  List<_InfoCita> _crearListaCita() {
    var citaInfo = <_InfoCita>[];
    _citas.sort((a, b) => a.fecha.isBefore(b.fecha) ? -1 : 1);
    for (Cita cita in _citas) {
      citaInfo.add(_InfoCita(cita: cita));
    }
    return citaInfo;
  }

  /*_nuevaCita(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NuevaCita()),
    );

    //if (resultado) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$resultado')));
    //}
  }*/
}

class _InfoCita extends StatefulWidget {
  _InfoCita({this.cita});
  final Cita cita;
  @override
  __InfoCitaState createState() => __InfoCitaState(cita: this.cita);
}

class __InfoCitaState extends State<_InfoCita> {
  __InfoCitaState({this.cita});
  final Cita cita;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  child: Text(
                    this.cita.nombre[0],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: colorFor(this.cita.nombre),
                  foregroundColor: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.cita.nombre,
                        style: Theme.of(context).textTheme.headline6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            this.cita.hora,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(this.cita.fecha),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: _citaMenu,
                itemBuilder: (BuildContext context) {
                  return {'Editar', 'Pagar', 'Eliminar'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Divider(height: 1.0),
          ),
        ],
      ),
    );
  }

  _citaMenu(String opcion) {
    switch (opcion) {
      case 'Editar':
        _editarCita(context, this.cita);
        break;
      case 'Pagar':
        _registrarPago(context);

        break;
      case 'Eliminar':
        break;
    }
  }

  _registrarPago(BuildContext context) async {
    bool resultado = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return PagoDialog();
        });
    if (resultado) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Se registró el pago.')));
    }
  }

  _editarCita(BuildContext context, Cita cita) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NuevaCita(cita: cita)),
    );

    if (resultado) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Cita editada correctamente.')));
    } else {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Algo salió mal al editar.')));
    }
  }

  Color colorFor(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    //final green = ((finalHash & 0xFF));
    final color = Color.fromRGBO(red, 0, blue, 0.5);
    return color;
  }
}
