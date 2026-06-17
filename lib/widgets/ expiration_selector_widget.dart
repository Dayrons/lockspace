import 'package:flutter/material.dart';

class ExpirationSelectorWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final dynamic Function(String, dynamic) onChanged;
  final String valueExpirationUnit;
  final String inputExpirationUnit;
  final int valueExpiration;
  final String inputExpiration;
  const ExpirationSelectorWidget({
    super.key,
    required this.onChanged,
    required this.valueExpiration,
    required this.inputExpiration,
    required this.inputExpirationUnit,
    required this.valueExpirationUnit,
    this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0XFF2b2e3d).withOpacity(0.5),
                  ),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: const Color(0XFF2CDA9D),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                    onChanged: (value) => onChanged(inputExpiration, int.tryParse(value) ?? 0),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0XFF2b2e3d).withOpacity(0.5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: const Color(0XFF23242a),
                      value: valueExpirationUnit,
                      style: const TextStyle(color: Colors.white),
                      items: const [
                        DropdownMenuItem(value: 'never', child: Text("Nunca")),
                        DropdownMenuItem(value: 'hours', child: Text("Horas")),
                        DropdownMenuItem(value: 'days', child: Text("Días")),
                        DropdownMenuItem(value: 'weeks', child: Text("Semanas")),
                        DropdownMenuItem(value: 'months', child: Text("Meses")),
                      ],
                      onChanged: (value) => onChanged(inputExpirationUnit, value),
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
