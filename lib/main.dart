import 'package:flutter/material.dart';
import 'login_page.dart';
import 'central_nav.dart';
import 'nueva_cita.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Salón de Belleza';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        title: _title,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/menu': (context) => HomeMenu(),
          '/nueva': (context) => NuevaCita(),
        },
        //al usar rutas no se define la propiedad home
        //home: LoginPage(),
        theme: ThemeData(
          primaryColor: Color(0xFF833995),
          accentColor: Color(0xFFC381D3),
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Citas',
      style: optionStyle,
    ),
    Text(
      'Index 1: Historial',
      style: optionStyle,
    ),
    Text(
      'Index 2: Catálogo',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: const Text('Salón de Belleza'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: _logout, tooltip: 'Salir'),
        ],
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Nueva Cita',
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF833995),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            label: 'Catálogo',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF833995),
        unselectedItemColor: Color(0xFFC381D3),
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
