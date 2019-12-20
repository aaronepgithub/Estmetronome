import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    bool isNumber(String value) {
      if (value == null) {
        return true;
      }
      final n = num.tryParse(value);
      print('final n: ' + n.toString());
      globals.globalSecondsPerCycle = n.toDouble();
      return n != null;
    }

    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w500);

    final TextStyle valueStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.pink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Enter 75% of Limitation",
                          style: titleStyle,
                          textAlign: TextAlign.start,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          //     TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value.isEmpty) {
                              return globals.globalSecondsPerCycle.toString();
                            }
                            return null;
                          },
                          initialValue:
                              globals.globalSecondsPerCycle.toString(),
                          textAlign: TextAlign.center,
                          onChanged: (String newVal) {
                            if (!isNumber(newVal)) {
                              print('!isNumber(newVal)');
                            }
                          },
                          style: valueStyle,
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
