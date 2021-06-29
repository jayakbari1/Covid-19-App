import 'package:flutter/material.dart';

class Slot extends StatefulWidget {
  final List slots;

  final bool themechanger;

  const Slot({Key key,this.slots, this.themechanger}) : super(key: key);
  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themechanger ? Colors.black : Colors.white,
      appBar: AppBar(title: Text('Available Slots')),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              color: widget.themechanger ? Colors.white : Colors.grey,
              height: MediaQuery.of(context).size.height/3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Center ID - ' +
                          widget.slots[index]['center_id'].toString(),
                      style: TextStyle(fontSize: 16,fontFamily: 'avenir'),
                    ),
                    Text(
                      'Center Name - ' + widget.slots[index]['name'].toString(),
                      style: TextStyle(fontSize: 16,fontFamily: 'avenir'),
                    ),
                    Text(
                      'Center Address - ' +
                          widget.slots[index]['address'].toString(),
                      style: TextStyle(fontSize: 16,fontFamily: 'avenir'),
                    ),
                    Divider(),
                    Text(
                      'Vaccine Name - ' +
                          widget.slots[index]['vaccine'].toString(),
                      style: TextStyle(fontSize: 16,fontFamily: 'avenir'),
                    ),
                    Divider(),
                    Text(
                      'Slots - ' + widget.slots[index]['slots'].toString(),
                      style: TextStyle(fontSize: 16,fontFamily: 'avenir'),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}