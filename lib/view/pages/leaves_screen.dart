import 'package:etime/DB/DB_Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../DB/items.dart';
import '../../utils/month_year_utils.dart';
import '../menu_bar_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LeavesScreen extends StatefulWidget {
  final List<Item> filteredList;
  final String status;
final String selectedMonth;
final int SelectedYear;

  const LeavesScreen({
    Key? key,
    required this.filteredList,
    required this.status,required this.selectedMonth,required this.SelectedYear,

  }) : super(key: key);

  @override
  _LeavesScreenState createState() => _LeavesScreenState();
}
class _LeavesScreenState extends State<LeavesScreen> {
  late List<Item> filteredList;


  List<String> _getMonthRange() {
    final now = DateTime.now();
    if (selectedYear < now.year) {
      return CustomDateUtils.monthNames.toSet().toList();
    } else {
      return CustomDateUtils.monthNames.sublist(0, now.month).toSet().toList();
    }
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.selectedMonth;
    print(widget.selectedMonth);
   selectedYear = widget.SelectedYear;
    selectedValue = widget.status;
    filteredList = getFilteredList();
  }
  @override
  void dispose() {
    super.dispose();
  }
  List<Item> getFilteredList() {
    if (selectedValue == 'All') {
      // Display all items
      return DbHelperScreen.twoColumnList
          .where((item) =>
      item.date.month == CustomDateUtils.monthNames.indexOf(selectedMonth) + 1 &&
          item.date.year == selectedYear)
          .toList();
    } else {
      // Display items with matching status
      return DbHelperScreen.twoColumnList
          .where((item) =>
      item.status == selectedValue &&
          item.date.month == CustomDateUtils.monthNames.indexOf(selectedMonth) + 1 &&
          item.date.year == selectedYear)
          .toList();
    }
  }

  String selectedValue = 'All';
  String selectedMonth=DateTime.now().month.toString();
  int selectedYear=DateTime.now().year;

  final formatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }



    Widget build(BuildContext context) {
      filteredList = getFilteredList();
      if (filteredList.isEmpty) {
        showToast('No records found');
      }

      return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            centerTitle: true,
            toolbarHeight: 60.2.h,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            elevation: 0.00,
            title: Text('eTimeTrackLite', style: GoogleFonts.aBeeZee(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.blue,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white, // Set your desired color here
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          drawer: MenuBarWidget(),
      body: Container(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              SingleChildScrollView(
            child: Row(


              children: [
                Padding(padding: EdgeInsets.only(left: 10.0),),
                 Text(
                    'Select Year:',
                    style: GoogleFonts.aBeeZee(fontSize: 13.sp),
                  ),
                SizedBox(width: 2.w), Container(
                decoration: BoxDecoration(
                border: Border.all(
                color: Colors.black,
                width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.only(left: 10.0),
                child:
                DropdownButton<int>(
                  value: selectedYear,
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedYear = newValue;
                        selectedMonth = _getMonthRange().last;

                      });
                    }
                  },
                  items: List.generate(10, (index) {
                    int year = DateTime
                        .now()
                        .year - index;
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(year.toString()),
                    );
                  }),
                ),
                ),
                SizedBox(width: 2.w),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Select Month:',
                    style: GoogleFonts.aBeeZee(fontSize: 13.sp),
                  ),
                ),
                SizedBox(width: 5.w), Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.black,
    width: 1.0,
    ),
    borderRadius: BorderRadius.circular(10.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child:
                DropdownButton<String>(
                  value: selectedMonth,

                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        print("selected year:$selectedMonth");
                        selectedMonth = newValue;
                      });
                    }
                  },
                  items: _getMonthRange().map(
                        (month) =>
                        DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        ),
                  ).toList(),
                ),),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;

              });
            },
            items: [
              DropdownMenuItem<String>(
                value: 'All',
                child: Text('All'),
              ),
              DropdownMenuItem<String>(
                value: 'Present',
                child: Text('Present'),
              ),
              DropdownMenuItem<String>(
                value: 'Absent',
                child: Text('Absent'),
              ),
              DropdownMenuItem<String>(
                value: 'Leave',
                child: Text('Leave'),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('InTime')),
                  DataColumn(label: Text('OutTime')),
                  DataColumn(label: Text('Shift')),
                  DataColumn(label: Text('Status')),
                ],
                rows: filteredList.map(
                      (item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(formatter.format(item.date))),
                        DataCell(Text(timeFormatter.format(item.inTime))),
                        DataCell(Text(timeFormatter.format(item.outTime))),
                        DataCell(Text(item.shiftType)),
                        DataCell(Text(item.status)),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    )));
  }
  }
