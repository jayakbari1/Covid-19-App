import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'Pages/VaccinationPage.dart';
import 'Pages/statePage.dart';
import 'Pages/countyPage.dart';
import 'Panels/infoPanel.dart';
import 'Panels/mosteffectedcountries.dart';
import 'Panels/worldwidepanel.dart';
import 'dataSource.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  Uri src = Uri.parse('https://corona.lmao.ninja/v3/covid-19/all');

  fetchWorldWideData() async {
    http.Response response = await http.get(src);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  Uri countrysrc =
      Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries?sort=cases');

  fetchCountryData() async {
    http.Response response = await http.get(countrysrc);
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  var darkThemeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
                value: darkThemeEnabled,
                onChanged: (changedTheme) {
                  setState(() {
                    darkThemeEnabled = changedTheme;
                  });
                }),
          ],
          centerTitle: false,
          title: Text(
            'COVID-19 TRACKER',
          ),
        ),
        body: RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Worldwide',
                      style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VaccinationPage(themeChanger: darkThemeEnabled)));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color:
                              darkThemeEnabled ? Colors.red : primaryBlack,
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'VaccinationSlot',
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryPage(themeChanger: darkThemeEnabled)));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  darkThemeEnabled ? Colors.red : primaryBlack,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Regional',
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => statePage(themeChanger: darkThemeEnabled)));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                  darkThemeEnabled ? Colors.red : primaryBlack,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'IndianCases',
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldwidePanel(
                      worldData: worldData,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most affected Countries',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              InfoPanel(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'WE ARE TOGETHER IN THE FIGHT',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
              SizedBox(
                height: 50,
              )
            ],
          )),
        ),
      ),
    );
  }
}
