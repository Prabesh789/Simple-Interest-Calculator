import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator App",
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  //Only static memebr can be initilazed here
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var displayResult = '';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); //Keyboard remove
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: principalController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal: e.g. 12000',
                      labelStyle: textStyle,
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter principal amount';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: rateController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'Enter Rate of Interest in %',
                      labelStyle: textStyle,
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter rete of intrest';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: timeController,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Time',
                            hintText: 'Time in years',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter time in year';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          value: _currentItemSelected,
                          onChanged: (String newValueSelected) {
                            //code to execute, when a menu item is selected
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Calculate',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                if (_formkey.currentState.validate()) {
                                  this.displayResult = _calculateTotalReturns();
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _rest();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  this.displayResult,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      margin: EdgeInsets.all(50),
      child: image,
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(timeController.text);

    double totalAmountPayable = principal + (principal * rate * time) / 100;

    String result =
        'After $time years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _rest() {
    principalController.text = '';
    rateController.text = '';
    timeController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
