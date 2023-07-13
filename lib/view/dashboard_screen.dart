import 'package:etime/view/pages/leaves_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../DB/DB_Helper.dart';
import '../DB/items.dart';
import '../utils/month_year_utils.dart';
import 'menu_bar_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late String selectedMonth;
  late int selectedYear;

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

  List<String> _getMonthRange() {
    final now = DateTime.now();
    if (selectedYear < now.year) {
      return CustomDateUtils.monthNames;
    } else {
      return CustomDateUtils.monthNames.sublist(0, now.month);
    }
  }

  Map<String, int> _getGroupedStatusCount(List<Item> itemList) {
    List<Item> filteredList = itemList.where((item) {
      DateTime itemDate = item.date;
      int selectedMonthIndex =
          CustomDateUtils.monthNames.indexOf(selectedMonth) + 1;
      return itemDate.month == selectedMonthIndex &&
          itemDate.year == selectedYear;
    }).toList();
    // Group the items by status and count the occurrences
    Map<String, int> statusCount = {
      'Present': 0,
      'Absent': 0,
      'Leave': 0,
    };
    print('$filteredList');
    for (var item in filteredList) {
      if (item.status == 'Present') {
        statusCount['Present'] = (statusCount['Present'] ?? 0) + 1;
      } else if (item.status == 'Absent') {
        statusCount['Absent'] = (statusCount['Absent'] ?? 0) + 1;
      } else if (item.status == 'Leave') {
        statusCount['Leave'] = (statusCount['Leave'] ?? 0) + 1;
      }
    }

    return statusCount;
  }

  List<PieChartSectionData> _getPieChartSections(Map<String, int> statusCount) {
    List<PieChartSectionData> sections = [];

    // Convert the status count map to pie chart sections, filtering out zero values
    statusCount.entries.forEach((entry) {
      if (entry.value != 0) {
        final section = PieChartSectionData(
            color: _getSectionColor(entry.key),
            value: entry.value.toDouble(),
            title: '${entry.key}: ${entry.value}',
            radius: 100,
            titleStyle: GoogleFonts.aBeeZee(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ));
        sections.add(section);
      }
    });

    return sections;
  }

  void handleSegmentTap(String selectedSection) {
    // Filter the itemList based on the selected month
    List<Item> filteredList = itemList.where((item) {
      DateTime itemDate = item.date;
      int selectedMonthIndex =
          CustomDateUtils.monthNames.indexOf(selectedMonth) + 1;
      return itemDate.month == selectedMonthIndex &&
          itemDate.year == selectedYear;
    }).toList();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeavesScreen(
            filteredList: filteredList
                .where((item) => item.status == selectedSection)
                .toList(),
            status: selectedSection,
            selectedMonth: selectedMonth,
            SelectedYear: selectedYear,
          ),
        ));

    print('Tapped section: $selectedSection');
  }

  Color _getSectionColor(String status) {
    // Define colors based on status
    if (status == 'Present') {
      return Colors.green;
    } else if (status == 'Absent') {
      return Colors.red;
    } else if (status == 'Leave') {
      return Colors.purple;
    } else {
      return Colors.grey;
    }
  }

  Widget _buildGrid(List<Item> filteredList, Map<String, int> statusCount) {
    if (statusCount.isEmpty) {
      return Container(); // Return an empty container if the list is empty
    }

    // Filter the data based on the selected month
    List<Item> filteredData = filteredList.where((item) {
      DateTime itemDate = item.date;
      int selectedMonthIndex =
          CustomDateUtils.monthNames.indexOf(selectedMonth) + 1;
      return itemDate.month == selectedMonthIndex &&
          itemDate.year == selectedYear;
    }).toList();

    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius:
            BorderRadius.circular(10), // Add border radius to the container
        color: Colors.white
            .withOpacity(0.1), // Set a background color with opacity
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: statusCount.length,
        itemBuilder: (context, index) {
          String status = statusCount.keys.elementAt(index);
          int count = statusCount[status] ?? 0;

          // Filter the data based on the selected status
          List<Item> filteredDataByStatus =
              filteredData.where((item) => item.status == status).toList();

          return GestureDetector(
            onTap: () {
              if (count != 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeavesScreen(
                      filteredList: filteredDataByStatus,
                      status: status,
                      selectedMonth: selectedMonth,
                      SelectedYear: selectedYear,
                    ),
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 1.0.w,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0.w,
                        ),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Center(
                      child: Text(status,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0.w,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('$count',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16.sp,
                            )),
                      )),
                ),
              ],
            ),
          );
        },
      ),
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
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
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
                            width: 1.0.w,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                        child: DropdownButton<int>(
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
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
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
                            width: 1.0.w,
                          ),
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                        child: DropdownButton<String>(
                          value: selectedMonth,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedMonth = newValue;
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
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 300.h,
                child: PieChart(
                  swapAnimationDuration:
                      Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.easeOut,
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    sections:
                        _getPieChartSections(_getGroupedStatusCount(itemList)),
                    sectionsSpace: 2,
                    centerSpaceRadius: 10,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null) {
                          return;
                        }

                        final clickedSectionIndex = pieTouchResponse
                            .touchedSection?.touchedSectionIndex;
                        if (clickedSectionIndex != null) {
                          final shownSections = _getGroupedStatusCount(itemList)
                              .entries
                              .where((entry) => entry.value > 0)
                              .map((entry) => entry.key)
                              .toList();
                          final selectedSection =
                              shownSections[clickedSectionIndex];
                          handleSegmentTap(selectedSection);
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 0.h,
              ),
              SizedBox(
                height: 0.h,
              ),
              SizedBox(
                height: 0.h,
              ),
              SizedBox(
                height: 0.h,
              ),
              _buildGrid(itemList, _getGroupedStatusCount(itemList)),
            ],
          ),
        ),
      ),
    );
  }
}
