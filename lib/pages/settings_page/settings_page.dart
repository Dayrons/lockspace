import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configuraciónes',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            "General",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Notificaciones",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Mantener sesion activa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
           SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              Row(
                children: [
                  Icon(
                    Icons.router,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Contener conexion ftp activa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
