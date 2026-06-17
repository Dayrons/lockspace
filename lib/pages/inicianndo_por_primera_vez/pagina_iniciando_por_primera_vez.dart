import 'package:app/pages/sign_up_page/sign_up_page.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaIniciandoPorPrimeravez extends StatefulWidget {
  const PaginaIniciandoPorPrimeravez({super.key});
  @override
  State<PaginaIniciandoPorPrimeravez> createState() =>
      _PaginaIniciandoPorPrimeravezState();
}

class _PaginaIniciandoPorPrimeravezState
    extends State<PaginaIniciandoPorPrimeravez> {
  final PageController _controller = PageController();
  int _pagina = 0;
  final List<Widget> _paginas = [
    Pagina(
      color: const Color(fondo),
      title: 'SOLO TU TIENES EL CONTROL',
      descripcion:
          'LockSpace no tiene conexion a ningun servidor por lo que las contraseñas estaran almacenadas solo en tu  dispositivo',
      img: 'assets/1.png',
    ),
    Pagina(
      color: const Color(fondo),
      title: 'FACIL Y RAPIDO',
      descripcion:
          'Actualiza, elimina y copia contraseñas en cuestion de segundos',
      img: 'assets/2.png',
    ),
    Pagina(
      color: const Color(fondo),
      title: 'UNA SOLA CONTRASEÑA',
      descripcion:
          'Una unica contraseña con la que te autenticaras y con la que seran encriptadas tus contraseñas',
      img: 'assets/3.png',
    ),
  ];

  void _onChanged(int index) {
    setState(() {
      _pagina = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF1c1d22),
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _paginas.length,
              onPageChanged: _onChanged,
              itemBuilder: (BuildContext context, int index) {
                return _paginas[index];
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_paginas.length, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                      height: 10,
                      width: (index == _pagina) ? 30 : 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _pagina)
                              ? const Color(detalles)
                              : const Color(detalles).withOpacity(0.5)),
                    );
                  }),
                ),
                InkWell(
                  onTap: () => {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint)
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    alignment: Alignment.center,
                    height: 40,
                    width: (_pagina == (_paginas.length - 1)) ? 100 : 40,
                    decoration: BoxDecoration(
                        color: const Color(detalles),
                        borderRadius: BorderRadius.circular(20)),
                    child: (_pagina == (_paginas.length - 1))
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUpPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              'Comenzar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : const Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            )
          ],
        ));
  }
}

class Pagina extends StatelessWidget {
  final Color color;
  final String title;
  final String descripcion;
  final String img;

  const Pagina({super.key, required this.color, required this.title, required this.descripcion, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.00),
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            width: 250.00,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40.00),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.00),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.00),
                child: Text(
                  descripcion,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      fontSize: 16.00),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
