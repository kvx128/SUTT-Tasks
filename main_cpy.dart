import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Page1(),));
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  // This is the default bill amount
  static const defaultBillAmount = 0.0;

  // This is the default tip percentage
  static const defaultTipPercentage = 15.0;

  // This is the TextEditingController which is used to keep track of the change in bill amount
  final _billAmountController =
  TextEditingController(text: defaultBillAmount.toString());

  // This is the TextEditingController which is used to keep track of the change in tip percentage
  final _tipPercentageController =
  TextEditingController(text: defaultTipPercentage.toString());

  // This stores the latest value of bill amount calculated
  double _billAmount = defaultBillAmount;

  // This stores the latest value of tip percentage calculated
  double _tipPercentage = defaultTipPercentage;

  double _tipAmount = defaultBillAmount * defaultTipPercentage / 100;

  @override
  void initState() {
    super.initState();
    _billAmountController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);

  }

  _onBillAmountChanged() {
    // This method tells the Flutter framework that the bill amount has
    // changed in this State, which causes it to rerun the build method of _TipCalculatorState
    // so that the display can reflect the updated value of bill amount
    setState(() {
      _billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
      _getTotalAmount();
    });
  }

  _onTipAmountChanged() {
    // This method tells the Flutter framework that the tip percentage has
    // changed in this State, which causes it to rerun the build method of _TipCalculatorState
    // so that the display can reflect the updated value of tip percentage
    setState(() {
      _tipPercentage = double.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  //This method is used to calculate the latest tip amount
  _getTipAmount() {
    _tipAmount = _billAmount * _tipPercentage / 100;
  }

  //This method is used to calculate the latest total amount
  _getTotalAmount() {
    _getTipAmount();
    _billAmount = _billAmount + _tipAmount;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tip Calculator',
            style:  TextStyle(
                fontFamily: 'Lobster',
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.amber,
        ),

        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    key: Key("tipPercentage"),
                    controller: _tipPercentageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter the Tip Percentage',
                      labelText: 'Tip %',
                    ),
                  ),

                  TextFormField(
                    key: Key('billAmount'),
                    controller: _billAmountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Enter the Bill Amount',
                      labelText: 'Bill Amount',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      navigateToPage2(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent,
                    ),
                    child: Text(
                      'Calculate',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),

    );
  }

  Future navigateToPage2(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page2(billAmount: _billAmount,tipAmount: _tipAmount) ));
  }

// @override
// void dispose() {
//   // To make sure we are not leaking anything, dispose any used TextEditingController
//   // when this widget is cleared from memory.
//   _billAmountController.dispose();
//   _tipPercentageController.dispose();
//   super.dispose();
// }

}


class Page2 extends StatelessWidget {

  // This is the default bill amount
  final double billAmount;

  // This is the default tip percentage
  final double tipAmount ;

  const Page2({Key key, this.billAmount, this.tipAmount}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tip Calculated',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Total Tip amount: $tipAmount',
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Total amount: $billAmount',
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: (){
                backToPage1(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent,
              ),
              child: Text(
                  'Back'
              ),
            )
          ],
        ),
      ),
    );
  }

  void backToPage1(context) {
    Navigator.pop(context);
  }
}
