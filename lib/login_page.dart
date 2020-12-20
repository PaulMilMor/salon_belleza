import 'package:flutter/material.dart';
import 'central_nav.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Salón de Belleza',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: '¿Cuál es tu correo?',
                    labelText: 'Correo',
                  ),
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : 'Ingresa un correo válido',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                child: TextFormField(
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '¿Cuál es tu contraseña?',
                    labelText: 'Contraseña',
                  ),
                  validator: (value) =>
                      value.trim().isEmpty ? 'Introduce la contraseña' : null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Salir'),
                      ),
                      onPressed: _exit,
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF833995)),
                      onPressed: _goHome,
                      child: Text('Iniciar Sesión'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goHome() {
    /*Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return MyStatefulWidget;
        },
      ),
    );*/
    /*Navigator.pushNamed(context, "/main");*/
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeMenu()),
    );
  }

  void _exit() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
