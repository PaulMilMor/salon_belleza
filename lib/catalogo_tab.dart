import 'package:flutter/material.dart';
//
import 'models.dart';

class CatalogoTab extends StatefulWidget {
  @override
  _CatalogoTabState createState() => _CatalogoTabState();
}

class _CatalogoTabState extends State<CatalogoTab> {
  List<ServicioBelleza> _catalogo = [
    ServicioBelleza(
      nombre: 'Cortes',
      descripcion:
          'Se realizan todo tipo de cortes de cabello para todos los públicos.',
      precio: 'Desde \$50 a \$100',
      img:
          'https://firebasestorage.googleapis.com/v0/b/salon-de-belleza-91c7f.appspot.com/o/Cat%C3%A1logo%2Fcorte.jpg?alt=media&token=e66af3c9-af0a-4b68-b16d-ff336da8a47f',
    ),
    ServicioBelleza(
      nombre: 'Secado',
      descripcion: 'Se aplica un secado de cabello total',
      precio: '\$40',
      img:
          'https://firebasestorage.googleapis.com/v0/b/salon-de-belleza-91c7f.appspot.com/o/Cat%C3%A1logo%2Fsecado.jpg?alt=media&token=044c2d57-aece-4174-91ea-4b65510e0f32',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (_, int index) => _crearListaServicio()[index],
        itemCount: _crearListaServicio().length,
      ),
    );
  }

  List<_InfoServicio> _crearListaServicio() {
    var catalogoInfo = <_InfoServicio>[];
    for (ServicioBelleza servicio in _catalogo) {
      catalogoInfo.add(_InfoServicio(servicio: servicio));
    }
    return catalogoInfo;
  }
}

class _InfoServicio extends StatelessWidget {
  _InfoServicio({this.servicio});
  final ServicioBelleza servicio;
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
                    backgroundImage: NetworkImage(this.servicio.img),
                    radius: 50,
                    backgroundColor: Color(0xFFC381D3),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.servicio.nombre,
                          style: Theme.of(context).textTheme.headline4),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 6, 42, 8),
                        child: Text(this.servicio.descripcion),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          this.servicio.precio,
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFC381D3)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(height: 1.0),
            ),
          ],
        ));
  }
}
