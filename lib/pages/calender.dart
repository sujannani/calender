import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:task/pages/cards.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final GlobalKey<_CalendarWidgetState> _calendarKey =
      GlobalKey<_CalendarWidgetState>();
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  DateTime _focusedDay = DateTime.now();
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());
  String selectedYear = "";

  void updateSelectedMonth(String month) {
    setState(() {
      selectedMonth = month;
      //selectedYear = year;
    });
    _calendarKey.currentState!.setState(() {
      _calendarKey.currentState!._focusedDay =
          DateTime(2023, months.indexOf(month) + 1, 01);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Image.asset('assets/Group.png'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Text(
                      'Attendance',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MonthYearDropdowns(
                    selectedMonth: selectedMonth,
                    selectedYear: selectedYear,
                    onMonthChanged: (String month) {
                      updateSelectedMonth(month);
                      _focusedDay = DateTime(_focusedDay.year, 1);
                      //// Update the selectedMonth variable
                    },
                    onYearChanged: (String year) {
                      setState(() {
                        selectedYear = year;
                        _calendarKey.currentState!._focusedDay =
                            DateTime(int.parse(year), _focusedDay.month, 1);
                      });
                    },
                  ),
                  Text(
                    "All",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Image.asset("assets/Vector.png"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: CalendarWidget(
                key: _calendarKey,
                onMonthChanged: (month) {
                  setState(() {
                    selectedMonth = month;
                  });
                },
                onYearChanged: (String value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Present :23d",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Absent :7d",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: SizedBox(
                height: 15,
                width: 340,
                child: LinearProgressIndicator(
                  value: (23 - 7) / 23,
                  color: Color(0xFF2E3192),
                  backgroundColor: Color(0xFFC4D5E9),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E3192),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Cards(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Cards(),
            )
          ],
        ),
      ),
    ));
  }
}

class CalendarWidget extends StatefulWidget {
  final ValueChanged<String> onMonthChanged;
  final ValueChanged<String> onYearChanged;
  const CalendarWidget(
      {Key? key, required this.onMonthChanged, required this.onYearChanged})
      : super(key: key);
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      headerVisible: false,
      firstDay: DateTime.utc(1900, 01, 01),
      lastDay: DateTime.utc(2026, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
        final month = DateFormat('MMMM').format(focusedDay);
        widget.onMonthChanged(month);
        final year = focusedDay.year.toString();
        widget.onYearChanged(year);
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Color(0xFF2E3192),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ),
    );
  }
}

class MonthYearDropdowns extends StatefulWidget {
  final String selectedMonth; // Pass the selected month as a parameter
  final ValueChanged<String> onMonthChanged;
  final ValueChanged<String> onYearChanged; // Callback function
  final String selectedYear;
  MonthYearDropdowns({
    required this.selectedMonth,
    required this.onMonthChanged,
    required this.onYearChanged,
    required this.selectedYear,
  });

  @override
  _MonthYearDropdownsState createState() => _MonthYearDropdownsState();
}

class _MonthYearDropdownsState extends State<MonthYearDropdowns> {
  String selectedYear = "2023";

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = [
    '2021', '2022', '2023', '2024', '2025',
    '2026' // You can add more years as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              int currentIndex = months.indexOf(widget.selectedMonth);
              if (currentIndex > 0) {
                widget.onMonthChanged(months[currentIndex - 1]);
              } else {
                int currentYearIndex = years.indexOf(selectedYear);
                if (currentYearIndex > 0) {
                  selectedYear = years[currentYearIndex - 1];
                  widget.onMonthChanged(months[months.length - 1]);
                }
              }
            });
          },
        ),
        DropdownButton<String>(
          elevation: 0,
          value: widget.selectedMonth,
          onChanged: (String? newValue) {
            setState(() {
              widget.onMonthChanged(newValue!);
            });
          },
          items: months.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
        ),
        Text(
          ' | ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        DropdownButton<String>(
          elevation: 0,
          value: selectedYear,
          onChanged: (String? newValue) {
            setState(() {
              selectedYear = newValue!;
              widget.onYearChanged(newValue);
            });
          },
          items: years.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            );
          }).toList(),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              int currentIndex = months.indexOf(widget.selectedMonth);
              if (currentIndex < months.length - 1) {
                widget.onMonthChanged(months[currentIndex + 1]);
              } else {
                int currentYearIndex = years.indexOf(selectedYear);
                if (currentYearIndex < years.length - 1) {
                  selectedYear = years[currentYearIndex + 1];
                  widget.onMonthChanged(months[0]);
                }
              }
            });
          },
        ),
      ],
    );
  }
}
