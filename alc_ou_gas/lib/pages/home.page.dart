import 'package:alc_ou_gas/widgets/logo.widget.dart';
import 'package:alc_ou_gas/widgets/submit-form.dart';
import 'package:alc_ou_gas/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcoolCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          microseconds: 1200,
        ),
        color: this._color,
        child: ListView(
          children: <Widget>[
            Logo(),
            this._completed
                ? Success(
                    reset: reset,
                    result: _resultText,
                  )
                : SubmitForm(
                    alcoolCtrl: _alcoolCtrl,
                    gasCtrl: _gasCtrl,
                    busy: this._busy,
                    submitFunc: calculate,
                  ),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    var alc = double.parse(
            this._alcoolCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
        100;
    var gas =
        double.parse(this._gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) /
            100;

    var res = alc / gas;

    setState(() {
      this._color = Colors.deepPurpleAccent;
      this._completed = false;
      this._busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          this._resultText = "Compensa utilizar Gasolina";
        } else {
          this._resultText = "Compensa utilizar Álcool";
        }

        this._busy = false;
        this._completed = true;
      });
    });
  }

  reset() {
    setState(() {
      this._alcoolCtrl = new MoneyMaskedTextController();
      this._gasCtrl = new MoneyMaskedTextController();
      this._completed = false;
      this._busy = false;
      this._color = Colors.deepPurple;
    });
  }
}
