import 'package:flutter/material.dart';

enum MedioPago { efectivo, tarjeta }

class PagoDialog extends StatefulWidget {
  @override
  _PagoDialogState createState() => _PagoDialogState();
}

class _PagoDialogState extends State<PagoDialog> {
  MedioPago _medio;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Datos de pago',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Medio de pago:',
                      style: TextStyle(fontSize: 16),
                      //style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Efectivo'),
                          leading: Radio(
                            value: MedioPago.efectivo,
                            groupValue: _medio,
                            onChanged: (MedioPago value) {
                              setState(() {
                                _medio = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                            title: const Text('Tarjeta'),
                            leading: Radio(
                                value: MedioPago.tarjeta,
                                groupValue: _medio,
                                onChanged: (MedioPago value) {
                                  setState(() {
                                    _medio = value;
                                  });
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money_sharp),
                labelText: 'Importe',
                hintText: '¿Cuánto pagó el cliente?',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFF833995)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
