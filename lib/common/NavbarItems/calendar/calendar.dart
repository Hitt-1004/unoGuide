import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/common/NavbarItems/calendar/date_provider.dart';
import 'package:unoquide/common/NavbarItems/calendar/date_utils.dart';
import 'package:unoquide/common/NavbarItems/calendar/events.dart' as even;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  List<even.Events> events = [];
  Future<List<even.Events>> fecthData() async {
    final events = <even.Events>[];
    final res = await http
        .get(Uri.parse('$baseURL/Events?schoolId=63275848690ac78efd493fcd'));
    if (res.statusCode == 200) {
      var coins = jsonDecode(res.body);
      for (var coin in coins) {
        events.add(even.Events.fromJson(coin));
      }
    }

    return events;
  }

  List<even.Events> eventsOfSelectedDate = [];
  @override
  void initState() {
    fecthData().then((value) {
      setState(() {
        events = value;
        eventsOfSelectedDate = events;
      });
    });
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            margin: EdgeInsets.only(top: height * 0.16),
            width: double.infinity,
            child: SfCalendar(
              dataSource: EventDataSource(events),
              view: CalendarView.month,
              initialDisplayDate: DateTime.now(),
              onLongPress: (details) {
                setState(() {
                  _selectedDate = details.date!;
                });
                showModalBottomSheet(
                    context: context, builder: (context) => TaskWidget());
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AddEvents();
            }));
          },
          child: const Icon(Icons.add),
        ));
  }

  TaskWidget() {
    List<even.Events> filteredEvents = [];
    eventsOfSelectedDate.forEach((element) {
      DateTime currDate = element.eventEnd;
      if (Utils.checkSameDay(currDate, _selectedDate) == true ||
          Utils.checkSameDay(element.eventStart, _selectedDate) == true) {
        filteredEvents.add(element);
      }
    });
    if (eventsOfSelectedDate.isEmpty) {
      return Container(
        height: 200,
        child: const Center(
          child: Text("No events"),
        ),
      );
    } else {
      return Material(
        color: backgroundColor,
        child: Container(
          height: 200,
          color: backgroundColor,
          child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
                  elevation: 1.1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: ListTile(
                    //isThreeLine: true,

                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),

                    titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    subtitleTextStyle: const TextStyle(color: Colors.black),
                    shape: Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade300.withOpacity(
                        0.5,
                      )),
                    ),
                    style: ListTileStyle.list,
                    title: Text(filteredEvents[index].eventTitle),
                    subtitle: Text(filteredEvents[index].eventDescription),
                    leading: const Icon(Icons.calendar_today_outlined),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${Utils.format(filteredEvents[index].eventStart.toString())[3]}",
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From - ${Utils.format(filteredEvents[index].eventStart.toString())[1]} ${Utils.format(filteredEvents[index].eventStart.toString())[2]}",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "To - ${Utils.format(filteredEvents[index].eventEnd.toString())[1]} ${Utils.format(filteredEvents[index].eventEnd.toString())[2]}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<even.Events> source) {
    this.appointments = source;
  }

  even.Events? getEvent(int index) => appointments![index] as even.Events;
  @override
  DateTime getStartTime(int index) {
    return getEvent(index)!.eventStart;
  }

  @override
  DateTime getEndTime(int index) {
    return getEvent(index)!.eventEnd;
  }

  @override
  String getSubject(int index) {
    return getEvent(index)!.eventTitle;
  }
}

class AddEvents extends StatefulWidget {
  final even.Events? events;
  const AddEvents({
    Key? key,
    this.events,
  }) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  late DateTime toDate;
  late DateTime fromDate;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedUser = "";

  @override
  void initState() {
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now().add(const Duration(hours: 2));
  }

  void saveEvent(Map<String, dynamic> body) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    try {
      final data = await http.post(Uri.parse('$baseURL/Event'),
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (data.statusCode == 201) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("error calender $e");
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(top: height * 0.16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text(
                      "Add Event",
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Map<String, dynamic> body = {
                            "eventDescription": descriptionController.text,
                            "eventEnd":
                                toDate.millisecondsSinceEpoch.toString(),
                            "eventLabel": "green",
                            "eventStart":
                                fromDate.millisecondsSinceEpoch.toString(),
                            "eventTitle": titleController.text,
                            "schoolId": "63275848690ac78efd493fcd",
                            "viewers": [selectedUser],
                          };
                          saveEvent(body);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        icon: const Icon(
                          Icons.done,
                          color: blackColor,
                        ),
                        label: const Text(
                          'Save',
                          style: TextStyle(color: blackColor),
                        ))
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          border: const UnderlineInputBorder(),
                          hintText: "Add Title",
                          hintStyle: const TextStyle(fontSize: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) => {},
                        controller: titleController,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Start Date & Time",
                        style: titleTextStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: ListTile(
                                // style: ListTileStyle.drawer,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                title: Text(Utils.toDate(fromDate)),
                                trailing: const Icon(Icons.arrow_drop_down),
                                onTap: () => pickFromDateTime(pickDate: true),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: ListTile(
                                  style: ListTileStyle.drawer,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(Utils.toTime(fromDate)),
                                  trailing: const Icon(Icons.arrow_drop_down),
                                  onTap: () =>
                                      pickFromDateTime(pickDate: false))),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "End Date & Time",
                        style: titleTextStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: ListTile(
                                  style: ListTileStyle.drawer,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(Utils.toDate(toDate)),
                                  trailing: const Icon(Icons.arrow_drop_down),
                                  onTap: () => pickToDateTime(pickDate: true))),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: ListTile(
                                  style: ListTileStyle.drawer,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(Utils.toTime(toDate)),
                                  trailing: const Icon(Icons.arrow_drop_down),
                                  onTap: () =>
                                      pickToDateTime(pickDate: false))),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Add Description",
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some description';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) => {},
                        controller: descriptionController,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Viewers",
                        style: titleTextStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text('All'),
                        leading: Radio(
                          value: "All",
                          groupValue: selectedUser,
                          onChanged: (value) {
                            setState(() {
                              selectedUser = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: const Text('Parents'),
                        leading: Radio(
                          value: "Parents",
                          groupValue: selectedUser,
                          onChanged: (value) {
                            setState(() {
                              selectedUser = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: const Text('Teachers'),
                        leading: Radio(
                          value: "Teachers",
                          groupValue: selectedUser,
                          onChanged: (value) {
                            setState(() {
                              selectedUser = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: const Text('Students'),
                        leading: Radio(
                          value: "Students",
                          groupValue: selectedUser,
                          onChanged: (value) {
                            setState(() {
                              selectedUser = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: const Text('Specific'),
                        leading: Radio(
                          value: "Specific",
                          groupValue: selectedUser,
                          onChanged: (value) {
                            setState(() {
                              selectedUser = value.toString();
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: selectedUser == "Specific" ? true : false,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Enter Email"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  TextStyle titleTextStyle() =>
      TextStyle(fontSize: 20, color: Colors.grey[900]);

  pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = date.add(const Duration(hours: 1));
    }
    setState(() {
      fromDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2019, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;

    setState(() {
      toDate = date;
    });
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    final event = even.Events(
        eventTitle: titleController.text,
        eventStart: fromDate,
        eventEnd: toDate,
        eventDescription: "",
        schoolId: "63275848690ac78efd493fcd");

    final provider = Provider.of<EventProvider>(
      context,
      listen: false,
    );

    provider.addEvent(event);

    Navigator.pop(context);
  }
}
