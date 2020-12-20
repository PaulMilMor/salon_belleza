import 'package:flutter/material.dart';

import 'nueva_cita.dart';

class CitasTab extends StatefulWidget {
  @override
  _CitasTabState createState() => _CitasTabState();
}

class _CitasTabState extends State<CitasTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _nuevaCita,
        tooltip: 'Nueva Cita',
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF833995),
      ),
    );
  }

  void _nuevaCita() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NuevaCita()),
    );
  }
}
