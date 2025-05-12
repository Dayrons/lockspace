import 'package:flutter/material.dart';



class SliderWidget extends StatelessWidget {
   final String text;
  final double width;
  final double value;
  final Function onChanged;
  final String input;
   SliderWidget({Key key, this.text, this.width, this.value, this.onChanged, this.input}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
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
                  width: width * 0.5,
                  child: Slider(
                    activeColor: Color(0XFF2CDA9D),
                    inactiveColor: Color(0XFF2b2e3d),
                    value: value,
                    min: 0.0,
                    max: 100.0,
                    label: "${value.round()}",
                    onChanged: (double newValue) {
                      onChanged(input, newValue);
                    },
                  ),
                ),
                Container(
                  width:width * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: ()=>onChanged(input, (value -1)), icon: Icon(Icons.arrow_left, color: Color(0XFF2CDA9D),), splashRadius: 0.1),
                      
                      Container(
                        width: 30,
                        child: Center(child: Text(
                          "${value.round()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),),
                      ),

                      IconButton(onPressed: ()=>onChanged(input, (value +1)), icon: Icon(Icons.arrow_right, color: Color(0XFF2CDA9D),), splashRadius: 0.1),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
