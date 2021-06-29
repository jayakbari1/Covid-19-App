import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../dataSource.dart';

class statePage extends StatefulWidget {
  final bool themeChanger;

  const statePage({Key key, this.themeChanger}) : super(key: key);

  @override
  _statePageState createState() => _statePageState();
}

class _statePageState extends State<statePage> {
  @override
  @override
  final String url = 'https://api.rootnet.in/covid19-in/stats/latest';

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }

  Future<List> datas;

  void initState() {
    super.initState();
    datas = getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*  actions: <Widget>[
            IconButton(icon: Icon(Icons.search),onPressed: (){

              showSearch(context: context, delegate: Search(countryData));

            },)
          ],*/
        title: Text('Indian Country Status'),
      ),
      body: Container(
        child: FutureBuilder(
          future: datas,
          builder: (BuildContext context, SnapShot) {
            if (SnapShot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: widget.themeChanger ? primaryBlack : Colors.white,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color:
                            widget.themeChanger ? Colors.black : Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SnapShot.data[index]['loc'].toString(),
                            style: TextStyle(
                                color: widget.themeChanger
                                    ? Colors.white
                                    : Colors.black,
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          //SizedBox(height: 10,),
                          Text(
                            'Confirmed : ${SnapShot.data[index]['confirmedCasesIndian'].toString()}',
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Active : ${SnapShot.data[index]['totalConfirmed'].toString()}',
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.blue),
                          ),
                          Text(
                            'Recovered : ${SnapShot.data[index]['discharged'].toString()}',
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.green),
                          ),
                          Text(
                            'Deaths : ${SnapShot.data[index]['deaths'].toString()}',
                            style: TextStyle(
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
//                               color: Colors.grey[900],

                                color: widget.themeChanger
                                    ? Colors.grey[100]
                                    : Colors.grey[900]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 36,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
