import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Slot.dart';

class VaccinationPage extends StatefulWidget {

  final bool themeChanger;

  const VaccinationPage({Key key, this.themeChanger}) : super(key: key);

  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {

  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController daycontroller = TextEditingController();
  String dropdownValue = '01';
  List slots = [];
  //-----------------------------------------------------

  fetchslots() async {
    await http
        .get(Uri.parse(
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
            pincodecontroller.text +
            '&date=' +
            daycontroller.text +
            '%2F' +
            dropdownValue +
            '%2F2021'))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Slot(
                slots: slots,
                themechanger: widget.themeChanger,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeChanger ? Colors.teal : Colors.white,
      appBar: AppBar(title: Text('Vaccination Slots'),titleTextStyle: TextStyle(fontFamily: 'avenir'),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 250,
              child: Image.asset('assets/images/vaccine.png',fit: BoxFit.cover,),
            ),
            TextField(
              controller: pincodecontroller,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(hintText: 'Enter PIN Code'),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: daycontroller,
                      decoration: InputDecoration(hintText: 'Enter Date'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Container(
                      height: 52,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          color: Colors.grey.shade400,
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () {
                    fetchslots();
                  },
                  child: Text('Find Slots'),
                ))
          ]),
        ),
      ),

    );
  }
}
