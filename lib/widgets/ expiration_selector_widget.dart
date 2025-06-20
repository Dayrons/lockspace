import 'package:flutter/material.dart';

class ExpirationSelectorWidget extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Function onChanged;
  final String valueExpirationUnit;
  final String inputExpirationUnit;
  final int valueExpiration;
  final String inputExpiration;
  ExpirationSelectorWidget({
    this.onChanged,
    this.valueExpiration,
    this.inputExpiration,
    this.inputExpirationUnit,
    this.valueExpirationUnit,
    this.controller,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0XFF2b2e3d).withOpacity(0.5),
                  ),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0XFF2CDA9D),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    onChanged: (value) => onChanged(inputExpiration, value),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0XFF2b2e3d).withOpacity(0.5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color(0XFF23242a),
                      value: valueExpirationUnit,
                      style: TextStyle(color: Colors.white),
                      items: [
                        DropdownMenuItem(value: 'never', child: Text("Nunca")),
                        DropdownMenuItem(value: 'hours', child: Text("Horas")),
                        DropdownMenuItem(value: 'days', child: Text("Días")),
                        DropdownMenuItem(
                            value: 'weeks', child: Text("Semanas")),
                        DropdownMenuItem(value: 'months', child: Text("Meses")),
                      ],
                      onChanged: (value) =>
                          onChanged(inputExpirationUnit, value),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
