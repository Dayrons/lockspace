import 'package:app/pages/detalle_password/pagina_detalle_password.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final int id;
  final String password;
  final String titulo;
  final List<Function> funciones;

  const Password({Key key, this.id, this.password, this.titulo, this.funciones})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PaginaDetallePassword(password: password),
          ),
        )
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 5.00),
        padding: EdgeInsets.symmetric(horizontal: 20.00, vertical: 20.00),
        decoration: BoxDecoration(
          color: Color(0XFF2b2e3d).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /* IconButton(
              splashRadius: 20.00,
              iconSize: 16.00,
              color: const Color(0XFF2CDA9D),
              icon: Icon(
                Icons.more_vert,
              ),
              onPressed: () {},
            ), */
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "$titulo",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.00),
              ),
              SizedBox(
                height: 5.00,
              ),
              Text(
                "password".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 10.00),
              ),
            ]),
            Row(
              children: [
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 16.00,
                  color: const Color(0XFF2CDA9D),
                  icon: Icon(
                    Icons.copy,
                  ),
                  onPressed: () {
                    FlutterClipboard.copy(password)
                        .then((value) => funciones[0]());
                  },
                ),
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 18.00,
                  color: const Color(0XFF2CDA9D),
                  icon: Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    funciones[1](id);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
