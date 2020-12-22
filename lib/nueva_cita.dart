import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NuevaCita extends StatefulWidget {
  @override
  _NuevaCitaState createState() => _NuevaCitaState();
}

class _NuevaCitaState extends State<NuevaCita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Agendar Cita"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Salir',
          ),
        ],
        elevation: 1,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _FormNuevaCita(),
          ],
        ),
      ),
    );
  }

  void _logout() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

class _FormNuevaCita extends StatefulWidget {
  @override
  __FormNuevaCitaState createState() => __FormNuevaCitaState();
}

class __FormNuevaCitaState extends State<_FormNuevaCita> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  TextEditingController _dateTextEditingController = TextEditingController();
  TextEditingController _timeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                icon: Icon(Icons.mode_edit),
                hintText: '¿Cuál es el nombre del cliente?',
                labelText: 'Nombre',
              ),
              validator: (value) =>
                  value.trim().isEmpty ? 'Introduce el nombre' : null,
            ),
            TextFormField(
              focusNode: AlwaysDisabledFocusNode(),
              controller: _dateTextEditingController,
              enableInteractiveSelection: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: 'Fecha',
              ),
              validator: (value) =>
                  value.trim().isEmpty ? 'Introduce la fecha' : null,
              onTap: () {
                _selectDate(context);
              },
            ),
            TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _timeTextEditingController,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.watch_later_outlined),
                  labelText: 'Hora',
                ),
                validator: (value) =>
                    value.trim().isEmpty ? 'Introduce la hora' : null,
                onTap: () {
                  _selectTime(context);
                }),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.local_phone),
                labelText: 'Teléfono',
                hintText: 'Número de teléfono del cliente',
              ),
              validator: (value) =>
                  value.trim().isEmpty ? 'Introduce el teléfono' : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Cancelar'),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF833995)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Cita guardada')));
                        //Navigator.of(context).pop();
                      }
                    },
                    child: Text('Guardar Cita'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF833995),
              ),
            ),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateTextEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateTextEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay newSelectedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime != null ? _selectedTime : TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xFF833995),
              ),
            ),
            child: child,
          );
        });
    if (newSelectedTime != null) {
      _selectedTime = newSelectedTime;
      _timeTextEditingController.text = _selectedTime.format(context);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
