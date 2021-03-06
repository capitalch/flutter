import 'package:flutter/material.dart';
//import "dart:convert";
import 'globals.dart' as globals;
import 'ibuki.dart' as ibuki;

class Health extends StatefulWidget {
  @override
  HealthState createState() {
    return HealthState();
  }
}

class HealthState extends State<Health> {
  bool isBusy = false;
  dynamic _healthSnapShot = {
    "opstockvalue": "",
    "closstockvalue": "",
    "stockover90days": "",
    "stockover180days": "",
    "stockover270days": "",
    "stockover360days": "",
    "profit": "",
    "grossprofit": ""
  };
  dynamic subs;

  @override
  void initState() {
    super.initState();
    subs = ibuki.filterOn('tunnel:get:business:health').listen((d){
      setState((){
        dynamic healthList = d['data'];
        isBusy=false;
        if(healthList.length > 0){
          _healthSnapShot = healthList[0];
        }
      });
    });
    ibuki.httpPost('tunnel:get:business:health');
    isBusy =true;
  }

  @override
  void dispose(){
    subs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic col = getColumn(_healthSnapShot);
    return Scaffold(
        appBar: AppBar(title: Text('Health'), leading: globals.Util.getBusyIndicator(isBusy),),
        body: Container(margin: EdgeInsets.all(40.0), child: col));
  }
}

dynamic getColumn(_healthSnapShot) {
  dynamic col =
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Op Stock:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['opstockvalue']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Clos Stock:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['closstockvalue']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 90 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['stockover90days']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 180 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['stockover180days']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 270 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['stockover270days']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 360 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['stockover360days']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Profit:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['profit']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Gross Profit:',
          textAlign: TextAlign.left,
        ),
        Text(
          globals.Util.getFormatted1(_healthSnapShot['grossprofit']) ?? "",
          textAlign: TextAlign.right,
        )
      ],
    ),
  ]);
  return (col);
}

/*

  // HealthState() {
  //   populate();
  // }
  
  populate() {
    globals.httpPost('tunnel:get:business:health').then((d) {
      if (mounted) {
        setState(() {
          dynamic healthList =
              json.decode(d.body); //.cast<Map<String, dynamic>>();
          if (healthList.length > 0) {
            _healthSnapShot = healthList[0];
          }
        });
      }
    });
  }

*/