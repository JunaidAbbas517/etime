import 'package:flutter/material.dart';
import 'package:etime/DB/items.dart';
import 'package:intl/intl.dart';

class DbHelperScreen extends StatelessWidget {
  final formatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');
  static final List<Item> twoColumnList = [
    Item( DateTime(2022, 12, 19),DateTime(2022, 12, 19, 9, 0), DateTime(2022, 12, 9, 17, 0), 'GS', 'Present'),
    Item( DateTime(2023, 7, 19),DateTime(2023, 7, 19, 9, 0), DateTime(2023, 7, 9, 17, 0), 'GS', 'Present'),
    Item( DateTime(2023, 6, 10),DateTime(2023, 6, 10, 9, 0), DateTime(2023, 6, 10, 17, 0), 'MS', 'Present'),
    Item( DateTime(2023, 6, 20),DateTime(2023, 6, 20, 9, 0), DateTime(2023, 6, 20, 17, 0), 'MS', 'Absent'),
    Item( DateTime(2023, 4, 12),DateTime(2023, 4, 12, 7, 40), DateTime(2023, 4, 12, 15, 30), 'AS', 'Absent'),
    Item( DateTime(2023, 3, 11),DateTime(2023, 3, 11, 3, 0), DateTime(2023, 3, 11, 16, 40), 'GS', 'Leave'),
    Item( DateTime(2023, 3, 21),DateTime(2023, 3, 21, 3, 0), DateTime(2023, 3, 21, 16, 40), 'GS', 'Present'),
    Item( DateTime(2023, 5, 11),DateTime(2023, 5, 11, 10, 0), DateTime(2023, 5, 11, 15, 0), 'GS', 'Leave'),
    Item(  DateTime(2023, 6, 22),DateTime(2023, 6, 11, 8, 30), DateTime(2023, 6, 11, 17, 20), 'NS', 'Leave'),
    Item( DateTime(2023, 6, 9),DateTime(2023, 6, 9, 11, 10), DateTime(2023, 6, 9, 16, 10), 'MS', 'Absent'),
    Item(  DateTime(2023, 7, 15),DateTime(2023, 7, 15, 10, 0), DateTime(2023, 7, 15, 18, 30), 'NS', 'Present'),
    Item(  DateTime(2023, 7, 12),DateTime(2023, 7, 12, 8, 30), DateTime(2023, 7, 12, 17, 20), 'NS', 'Leave'),
    Item( DateTime(2023, 7, 1),DateTime(2023, 7, 1, 11, 10), DateTime(2023, 7, 1, 16, 10), 'MS', 'Absent'),
    Item( DateTime(2023, 7, 29),DateTime(2023, 7, 29, 11, 10), DateTime(2023, 7, 29, 16, 10), 'MS', 'Absent'),
    Item(  DateTime(2023, 6, 15),DateTime(2023, 6, 15, 10, 0), DateTime(2023, 6, 15, 18, 30), 'NS', 'Present'),
    Item(  DateTime(2023, 7, 18),DateTime(2023, 7, 18, 10, 0), DateTime(2023, 7, 18, 18, 30), 'NS', 'Present'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'eTimeTrackLite',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
      body: ListView.builder(
        itemCount: twoColumnList.length,
        itemBuilder: (context, index) {
          final item = twoColumnList[index];
          return ListTile(
            title: Text('Date: ${formatter.format(item.date)}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('InTime: ${timeFormatter.format(item.inTime)}'),
                Text('OutTime: ${timeFormatter.format(item.outTime)}'),
                Text('Shift: ${item.shiftType}'),
                Text('Status: ${item.status}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
