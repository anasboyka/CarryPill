import 'dart:ui';

import 'package:carrypill/constants/constant_widget.dart';
import 'package:flutter/material.dart';

class RadioListChoice extends StatefulWidget {
  final String choiceName;
  int index;
  bool status;
  Function(int val) radioToggle;

  RadioListChoice({
    Key? key,
    required this.choiceName,
    required this.index,
    required this.status,
    required this.radioToggle,
  }) : super(key: key);

  @override
  State<RadioListChoice> createState() => _RadioListChoiceState();
}

class _RadioListChoiceState extends State<RadioListChoice> {
  late int? index;
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    index = widget.index;
    status = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Radio<int?>(
            toggleable: true,
            activeColor: Colors.green,
            value: index,
            groupValue: status ? index : null,
            onChanged: (val) {
              //print(val as int);
              val as int;
              setState(() {
                //print(val);
                status = !status;
                widget.radioToggle(widget.index);
              });
            },
          ),
        ),
        gapwr(),
        Text(
          widget.choiceName,
          style: kwstyleb15,
        ),
      ],
    );
  }
}
