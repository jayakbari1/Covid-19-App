import 'package:covid19_app/dataSource.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';

class CountryPage extends StatefulWidget {

  final bool themeChanger;

  const CountryPage({Key key, this.themeChanger}) : super(key: key);
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;


  Uri countrysrc = Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries');

  fetchCountryData() async {
    http.Response response =
    await http.get(countrysrc);
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeChanger ? Colors.transparent : Colors.white,
      appBar: AppBar(
       actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){
            showSearch(context: context, delegate: Search(countryData));
          },)
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: widget.themeChanger ? Colors.transparent : Colors.white,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: widget.themeChanger? Colors.black : Colors.white,
              ),

              margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          countryData[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold,
                          color: widget.themeChanger ? Colors.grey : Colors.black),
                        ),
                        Image.network(
                          countryData[index]['countryInfo']['flag'],
                          height: 50,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CONFIRMED:' +
                                  countryData[index]['cases'].toString(),
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              'ACTIVE:' +
                                  countryData[index]['active'].toString(),
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              'RECOVERED:' +
                                  countryData[index]['recovered'].toString(),
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            Text(
                              'DEATHS:' +
                                  countryData[index]['deaths'].toString(),
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontWeight: FontWeight.bold,
                                  color: widget.themeChanger?Colors.grey[100]:Colors.grey[900]),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          );
        },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}