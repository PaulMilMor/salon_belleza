import 'package:flutter/material.dart';

import 'catalogo_tab.dart';
import 'citas_tab.dart';
import 'historial_tab.dart';

class HomeMenu extends StatefulWidget {
  HomeMenu({Key key}) : super(key: key);
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> tabs = [CitasTab(), HistorialTab(), CatalogoTab()];
  final List<String> titles = ['Citas', 'Historial', 'Catálogo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: _logout, tooltip: 'Salir'),
        ],
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: tabs[_selectedIndex],
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
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
