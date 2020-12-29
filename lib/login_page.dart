import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//
import 'firebase_metodos.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _pswdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Salón de Belleza',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                    child: TextFormField(
                      controller: _emailEditingController,
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
                      controller: _pswdEditingController,
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
                      validator: (value) => value.trim().isEmpty
                          ? 'Introduce la contraseña'
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
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
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF833995)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //_goHome();
                              _login(context);
                            }
                          },
                          child: Text('Iniciar Sesión'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context2) async {
    final resultado = await context.read<FirebaseProvider>().iniciarSesion(
          correo: _emailEditingController.text.trim(),
          contra: _pswdEditingController.text.trim(),
        );

    //if (resultado != 'Ingresó') {
    Scaffold.of(context2)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resultado)));
    //}
  }

  void _goHome() {
    Navigator.pushNamed(context, '/menu');
    _emailEditingController.clear();
    _pswdEditingController.clear();
    _formKey.currentState.reset();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild.unfocus();
    }
  }

  void _exit() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
