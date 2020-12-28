import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//
import 'models.dart';

class HistorialTab extends StatefulWidget {
  @override
  _HistorialTabState createState() => _HistorialTabState();
}

class _HistorialTabState extends State<HistorialTab> {
  List<Cita> _citas = [
    Cita(
      nombre: 'Juan',
      fecha: DateTime.utc(2020, 12, 25),
      hora: '10:30',
      telefono: '6623642724',
      monto: '500',
    ),
    Cita(
      nombre: 'Felix Gutierrez',
      fecha: DateTime.utc(2020, 12, 18),
      hora: '10:30',
      telefono: '6622048032',
      monto: '420',
    ),
    Cita(
      nombre: 'faro',
      fecha: DateTime.utc(2020, 11, 28),
      hora: '10:30',
      telefono: '6622334455',
      monto: '1222',
    ),
  ];
  String dropdownValue = 'Todo el historial';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>[
                  'Todo el historial',
                  'Últimas 24 horas',
                  'Última semana',
                  'Última quincena',
                  'Último mes'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(value),
                      alignment: Alignment.center,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Divider(height: 2.0),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _crearListaHistorial()[index],
              itemCount: _crearListaHistorial().length,
            ),
          ),
        ],
      ),
    );
  }

  List<_InfoHistorial> _crearListaHistorial() {
    var citaInfo = <_InfoHistorial>[];
    _citas.sort((a, b) => a.fecha.isBefore(b.fecha) ? 1 : -1);
    var fechaHoy = DateTime.now();
    var fechaAyer =
        DateTime(fechaHoy.year, fechaHoy.month, fechaHoy.day - 1, 0, 0);
    var fechaSemana =
        DateTime(fechaHoy.year, fechaHoy.month, fechaHoy.day - 7, 0, 0);
    var fechaQuincena =
        DateTime(fechaHoy.year, fechaHoy.month, fechaHoy.day - 15, 0, 0);
    var fechaMes =
        DateTime(fechaHoy.year, fechaHoy.month - 1, fechaHoy.day, 0, 0);
    switch (dropdownValue) {
      case 'Todo el historial':
        citaInfo.clear();
        for (Cita cita in _citas) {
          citaInfo.add(_InfoHistorial(cita: cita));
        }
        break;
      case 'Últimas 24 horas':
        citaInfo.clear();
        for (Cita cita in _citas) {
          if (cita.fecha.isAfter(fechaAyer))
            citaInfo.add(_InfoHistorial(cita: cita));
        }
        break;
      case 'Última semana':
        citaInfo.clear();
        for (Cita cita in _citas) {
          if (cita.fecha.isAfter(fechaSemana))
            citaInfo.add(_InfoHistorial(cita: cita));
        }
        break;
      case 'Última quincena':
        citaInfo.clear();
        for (Cita cita in _citas) {
          if (cita.fecha.isAfter(fechaQuincena))
            citaInfo.add(_InfoHistorial(cita: cita));
        }
        break;
      case 'Último mes':
        citaInfo.clear();
        for (Cita cita in _citas) {
          if (cita.fecha.isAfter(fechaMes))
            citaInfo.add(_InfoHistorial(cita: cita));
        }
        break;
    }

    return citaInfo;
  }
}

class _InfoHistorial extends StatefulWidget {
  _InfoHistorial({this.cita});
  final Cita cita;
  @override
  __InfoHistorialState createState() => __InfoHistorialState(cita: this.cita);
}

class __InfoHistorialState extends State<_InfoHistorial> {
  __InfoHistorialState({this.cita});
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$${cita.monto}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, color: Color(0xFFC381D3)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Divider(height: 1.0),
          ),
        ],
      ),
    );
  }

  Color colorFor(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    final color = Color.fromRGBO(red, 0, blue, 0.5);
    return color;
  }
}
