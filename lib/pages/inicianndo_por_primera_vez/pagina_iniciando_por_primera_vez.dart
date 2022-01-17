
import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';

class PaginaIniciandoPorPrimeravez extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      body: PageView(
        children: [
          Pagina(
            color: Color(0XFF1c1d22),
          ),
          Pagina(
            color: Color(0XFF1c1d22),
          ),
          Pagina1()
        ],
      ),
    );
  }
}

class Pagina extends StatelessWidget {
  final Color color;

  const Pagina({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.00),
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/1.png',
            width: 250.00,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.00),
                child: Text(
                  'SOLO TU TIENES EL CONTROL',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.00),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.00),
                child: Text(
                  'LockSpace no tiene conexion a ningun servidor por lo que las contraseñas estaran almacenadas e incriptadas en tu mismo dispositivo',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      fontSize: 16.00),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 40.00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Container(
                      width: 15.00,
                      height: 15.00,
                      margin: EdgeInsets.symmetric(horizontal: 10.00),
                      decoration: BoxDecoration(
                        color: const Color(0XFF2CDA9D),
                        shape: BoxShape.circle
                      ),
                     
                    ),
                    Container(
                      width: 15.00,
                      height: 15.00,
                      margin: EdgeInsets.symmetric(horizontal: 10.00),
                      decoration: BoxDecoration(
                        color: const Color(0XFF25262b),
                        shape: BoxShape.circle
                      ),
                     
                    ),
                    Container(
                      width: 15.00,
                      height: 15.00,
                      margin: EdgeInsets.symmetric(horizontal: 10.00),
                      decoration: BoxDecoration(
                        color: const Color(0XFF25262b),
                        shape: BoxShape.circle
                      ),
                     
                    ),
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 40.00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10.00,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.00, vertical: 10.00),
                      decoration: BoxDecoration(
                        color: const Color(0XFF2CDA9D),
                        borderRadius: BorderRadius.circular(5.00)
                      ),
                      child: Text(
                        'Siguiente',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.00),
                      ),
                    )
                  ],
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}



class Pagina1 extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.symmetric(horizontal: 20.00),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Input(texto: 'Contraseña',)
      ],),
    );
  }
}