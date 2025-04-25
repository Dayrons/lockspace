import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/pages/list_password_page/widgets/password.dart';
import 'package:app/pages/registrar_password/pagina_registrar_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPasswordPage extends StatefulWidget {
  @override
  State<ListPasswordPage> createState() => _ListPasswordPageState();
}

class _ListPasswordPageState extends State<ListPasswordPage> {
  double opacidad = 0;

  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20,),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0XFF2b2e3d).withOpacity(0.5),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Color(0XFF2CDA9D),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "Buscar",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: _search,
                ),
              ),
              IconButton(
                iconSize: 28,
                splashRadius:
                    25, // Reduced splash radius based on container height
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        PaginaRegistrarPassword(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(child:
              BlocBuilder<GestionpasswordBloc, GestionpasswordState>(
                  builder: (context, state) {
            if (state.obteniendoPassword) {
              return Text('Obteniendo password');
            } else {
              if (state.passwords.length > 0) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.passwords.length,
                  itemBuilder: (BuildContext context, int index) {
                  final password = state.passwords[index];
                  return Password(
                    id: password.id,
                    titulo: password.titulo,
                    password: password.decryptFernet(password.password),
                    funciones: [_notificacion, _eliminarPassword],
                  );
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/4.png',
                      width: 140,
                    ),
                    SizedBox(
                      height: 20.00,
                    ),
                    Text(
                      'No tienes ninguna contraseña',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.00,
                      ),
                    )
                  ],
                );
              }
            }
          }))
        ],
      ),
    );
  }

  void _search(String text) {
    BlocProvider.of<GestionpasswordBloc>(context)
        .add(FiltrarPassword(search: text));
  }

  void init(BuildContext context) {
    BlocProvider.of<GestionpasswordBloc>(context).add(ObtenerPasswords());
  }

  void _notificacion() async {
    setState(() {
      opacidad = 1;
    });
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {
      opacidad = 0;
    });
  }

  void _eliminarPassword(id) {
    BlocProvider.of<GestionpasswordBloc>(context).add(EliminarPassword(id: id));
  }
}
