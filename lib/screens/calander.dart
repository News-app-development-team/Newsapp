import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phnauthnew/views/date_view.dart';

class Calander extends StatefulWidget {
  @override
  _CalanderState createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  DateTime selectedDate;
  var formattedDate="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formattedDate,style: TextStyle(
              fontSize: 30.0,
              color: Colors.pink,
            ),),
            RaisedButton(
              color: Colors.blue,
              child: Text('selct a date'),
              onPressed: ()async {
                bool _decideWhichDayToEnable(DateTime day) {
                  if ((day.isAfter(DateTime.now().subtract(Duration(days: 30))) &&
                      day.isBefore(DateTime.now().add(Duration(days: 10))))) {
                    return true;
                  }
                  return false;
                }
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2019),
                  lastDate: DateTime.now(),
                  selectableDayPredicate: _decideWhichDayToEnable,
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light(),
                      child: child,
                    );
                  },
                );
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                    var date = DateTime.parse(selectedDate.toString());
                    formattedDate = "${date.year}-${date.month}-${date.day}";
                  });
              }
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('search'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Datesearch(date: formattedDate,)
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
