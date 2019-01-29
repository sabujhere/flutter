import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Ccalcu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  final double formDistance = 5.0;
  final currencies = ['Dollars', 'Euro', 'Pounds'];
  String currency = 'Dollars';
  TextEditingController distanceControler = TextEditingController();
  TextEditingController avgControler = TextEditingController();
  TextEditingController priceControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: formDistance, bottom: formDistance),
              child: TextField(
                controller: distanceControler,
                decoration: InputDecoration(
                    labelText: 'Distance',
                    hintText: 'e.g. 124',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding:
                EdgeInsets.only(top: formDistance, bottom: formDistance),
                child: TextField(
                  controller: avgControler,
                  decoration: InputDecoration(
                      labelText: 'Distance per Unit',
                      hintText: 'e.g. 17',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding:
                EdgeInsets.only(top: formDistance, bottom: formDistance),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: priceControler,
                        decoration: InputDecoration(
                            labelText: 'Price',
                            hintText: 'e.g. 1.65',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(width: formDistance * 5),
                    Expanded(
                        child: DropdownButton<String>(
                            items: currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: currency,
                            onChanged: (String value) {
                              setState(() {
                                currency = value;
                              });
                            })),
                  ],
                )),
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          result = _calculate();
                        });
                      },
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                    )),
                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                    )),
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  String _calculate() {
    double _distance = double.parse(distanceControler.text);
    double _fuelCost = double.parse(priceControler.text);
    double _consumption = double.parse(avgControler.text);

    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        currency;
    return _result;
  }

  void _reset() {
    distanceControler.text = '';
    priceControler.text = '';
    avgControler.text = '';
    result = '';
    setState(() {

    });
  }
}
//test