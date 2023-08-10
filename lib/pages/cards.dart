import 'package:flutter/material.dart';

// Cards widget
class Cards extends StatefulWidget {
  const Cards({
    Key? key,
  }) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  bool isDropdownOpen = false;
  String dropdownValue = 'Present'; // Track the selected dropdown value
  List listItem = [
    'Present',
    'Absent',
    'Half-Time',
  ];
  bool isExpanded = false;
  bool isActivityExpanded = false;
  double tableHeight = 0;
  List<Map<String, String>> rowData = [
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
    {
      'clocked In & Out': '9:00 AM - 10:30 AM',
      'Total': '3 Hrs',
      'Other Stats': ''
    },
  ];
  int hours = 6;

  @override
  Widget build(BuildContext context) {
    final Cardwidth = MediaQuery.of(context).size.width;
    int rowCount = rowData.length;
    double rowHeight = 36.0; // Adjust this value to match your row height
    double tablePadding = 16.0; // Adjust this value to match your row height
    tableHeight = (rowCount * rowHeight) + tablePadding;

    return GestureDetector(
      onTap: () {
        setState(() {
          isActivityExpanded = !isActivityExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Morning',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // SizedBox(width: 0),
                    SizedBox(width: Cardwidth * 0.30),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: null,
                      iconDisabledColor: Colors.white,
                      underline: Container(
                        height: 0,
                        color: const Color(0x3EEB6E38),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (newValue == 'Present') {
                            hours = 6;
                          } else if (newValue == 'Absent') {
                            hours = 0;
                          } else if (newValue == 'Half-Time') {
                            hours = 3;
                          }
                        });
                      },
                      alignment: Alignment.bottomCenter,
                      items: <String>[
                        'Present',
                        'Absent',
                        'Half-Time',
                      ].map<DropdownMenuItem<String>>((String value) {
                        Color backgroundColor;
                        Color textColor;

                        if (value == 'Present') {
                          backgroundColor =
                              const Color.fromARGB(255, 128, 233, 131);
                          textColor = Colors.green;
                        } else if (value == 'Absent') {
                          backgroundColor =
                              const Color.fromARGB(255, 199, 134, 129);
                          textColor = Colors.red;
                        } else if (value == 'Half-Time') {
                          backgroundColor =
                              const Color.fromARGB(255, 221, 183, 125);
                          textColor = Colors.orange;
                        } else {
                          backgroundColor = Colors.white;
                          textColor = Colors.white;
                        }

                        return DropdownMenuItem<String>(
                          value: value,
                          child: Column(
                            children: [
                              Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                child: Text(
                                  value,
                                  style:
                                      TextStyle(color: textColor, fontSize: 17),
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(width: 0),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '9:00 AM - 4:00 PM',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Clocked In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Clocked Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "9:00 AM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "11:30 AM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "2 hrs",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 2),
                            Text(
                              'Office In Vijayawada',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Activity',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          isActivityExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isActivityExpanded ? tableHeight : 0,
                  child: Visibility(
                    visible: isActivityExpanded,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        border: const TableBorder(
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                          horizontalInside:
                              BorderSide.none, // Remove borders between rows
                          verticalInside:
                              BorderSide.none, // Remove borders between columns
                          top: BorderSide(
                              width: 1.0,
                              color: Colors
                                  .black), // Add a border to the top of the table
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        // border: TableBorder.lerp(),
                        children: [
                          const TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Clock In & Out',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Other Stats',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (var data in rowData)
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data['clocked In & Out']!),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data['Total']!),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data['Other Stats']!),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
