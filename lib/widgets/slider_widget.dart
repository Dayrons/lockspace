import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final String text;
  final double width;

  const SliderWidget({Key key, this.text, this.width}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0XFF2b2e3d).withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  width: widget.width * 0.7,
                  child: Slider(
                    activeColor: Color(0XFF2CDA9D),
                    inactiveColor: Color(0XFF2b2e3d),
                    value: _currentValue,
                    min: 0.0,
                    max: 100.0,
                    label: "${_currentValue.round()}",
                    onChanged: (double newValue) {
                      setState(() {
                        _currentValue = newValue;
                      });
                    },
                  ),
                ),
                Container(
                  width: widget.width * 0.1,
                  child: Center(
                      child: Text(
                    "${_currentValue.round()}",
                    style: TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
