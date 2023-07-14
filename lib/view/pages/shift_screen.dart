import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../DB/DB_Helper.dart';
import '../../DB/items.dart';
import '../../utils/month_year_utils.dart';
import '../menu_bar_screen.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({Key? key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late String selectedMonth;
  late int selectedYear;

  List<String> _getMonthRange() {
    final now = DateTime.now();
    if (selectedYear < now.year) {
      return CustomDateUtils.monthNames;
    } else {
      return CustomDateUtils.monthNames.sublist(0, now.month);
    }
  }

  List<Item> itemList = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = CustomDateUtils.getMonthName(now.month);
    selectedYear = now.year;
    // Call the method to fetch the data from DBHelper class and populate the itemList
    fetchData();
  }

  Future<void> fetchData() async {
    // Use your DBHelper class to fetch the data
    List<Item> data = await DbHelperScreen.twoColumnList;
    setState(() {
      itemList = data;
    });
  }

  void _onYearMonthChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  Widget _buildShiftMarker(DateTime date) {
    List<Item> shifts =
        itemList.where((item) => isSameDay(item.date, date)).toList();

    if (shifts.isEmpty && date.weekday == DateTime.sunday) {
      return Text(
        'WO',
        style: GoogleFonts.aBeeZee(fontSize: 12, color: Colors.red),
      );
    }

    if (shifts.isEmpty) {
      return Container();
    }

    return Row(
      children: shifts.map((shift) {
        return Expanded(
          child: Text(
            '${shift.shiftType}',
            textAlign: TextAlign.center, // Align text to the center
            style: GoogleFonts.aBeeZee(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'eTimeTrackLite',
          style: GoogleFonts.aBeeZee(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [
              SingleChildScrollView(
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Select Year:',
                            style: GoogleFonts.aBeeZee(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<int>(
                            value: selectedYear,
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedYear = newValue;
                                  selectedMonth = _getMonthRange().last;
                                  _onYearMonthChanged(DateTime(
                                      selectedYear,
                                      CustomDateUtils.monthNames
                                              .indexOf(selectedMonth) +
                                          1,
                                      1));
                                });
                              }
                            },
                            items: List.generate(10, (index) {
                              int year = DateTime.now().year - index;
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            'Select Month:',
                            style: GoogleFonts.aBeeZee(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton<String>(
                            value: selectedMonth,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedMonth = newValue;
                                  _onYearMonthChanged(DateTime(
                                      selectedYear,
                                      CustomDateUtils.monthNames
                                              .indexOf(selectedMonth) +
                                          1,
                                      1));
                                });
                              }
                            },
                            items: _getMonthRange()
                                .map(
                                  (month) => DropdownMenuItem<String>(
                                    value: month,
                                    child: Text(
                                      month,
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Container(
                width: 350.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0.w,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$selectedMonth',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' $selectedYear', // Replace with the variable holding the selected year
                          style: GoogleFonts.aBeeZee(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime(
                        selectedYear,
                        CustomDateUtils.monthNames.indexOf(selectedMonth) + 1,
                        1),
                    lastDay: DateTime(
                        selectedYear,
                        CustomDateUtils.monthNames.indexOf(selectedMonth) + 1,
                        _getDaysInMonth(
                            selectedYear,
                            CustomDateUtils.monthNames.indexOf(selectedMonth) +
                                1)),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    headerVisible: false,
                    onPageChanged: (focusedDay) {
                      _onYearMonthChanged(focusedDay);
                    },
                    availableGestures: AvailableGestures.all,
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(fontSize: 18.sp),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        return _buildShiftMarker(date);
                      },
                    ),
                  ),
                ]),
              )
            ])),
      ),
    );
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
