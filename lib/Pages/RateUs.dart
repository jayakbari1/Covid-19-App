import 'package:covid19_app/dataSource.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'smiley_controller.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key key}) : super(key: key);

  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  double _rating = 5.0;
  String _currentAnimation = '5+';
  SmileyController _smileyController = SmileyController();

  void _onChanged(double value) {
    if (_rating == value) return;

    setState(() {
      var direction = _rating < value ? '+' : '-';
      _rating = value;
      _currentAnimation = '${value.round()}$direction';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        title: Text('Rate Us'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: FlareActor(
                'assets/happiness_emoji.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                controller: _smileyController,
                animation: _currentAnimation,
              ),
            ),
            Slider(
              activeColor: Colors.grey,
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: _onChanged,
            ),
            Text(
              '$_rating',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: 'Your response successfully submitted',
                    fontSize: 15,
                    backgroundColor: Colors.white,
                  );
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}
