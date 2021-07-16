// import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:add_2_calendar/add_2_calendar.dart' as add_2_calendar;
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/components/requestCard.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/Booking.dart';
import 'package:redcircleflutter/screens/BookingServices/components/Booking_description.dart';
import 'package:redcircleflutter/screens/offers/components/offer_description.dart';
import 'package:redcircleflutter/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// final Map<DateTime, List> _holidays = {
//   DateTime(2020, 1, 1): ['New Year\'s Day'],
//   DateTime(2020, 1, 6): ['Epiphany'],
//   DateTime(2020, 2, 14): ['Valentine\'s Day'],
//   DateTime(2020, 4, 21): ['Easter Sunday'],
//   DateTime(2020, 4, 22): ['Easter Monday'],
// };

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  List _selectedEvents;
  bool monthFormat = true;
  final DateFormat formatter = DateFormat('EEE dd MMM yyyy');
  String _selectedDay;

  AnimationController _animationController;
  CalendarController _calendarController;

  Future<Map<DateTime, List>> getTask() async {
    Map<DateTime, List> mapFetch = {};

    await Future.delayed(const Duration(seconds: 3), () {});

    /*String link = baseURL + fetchTodoByDate;
    var res = await http.post(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      // need help in creating fetch logic here
    }*/

    String responseString =
        '''
    {
    "error": "0",
    "message": "Got it!",
    "data": [
        {
            "status": false,
            "_id": "5e04a27692928701258b9b06",
            "group_id": "5df8aaae2f85481f6e31db59",
            "date": "2019-12-29T00:00:00.000Z",
            "title": "new task",
            "priority": 5,
            "description": "just a description",
            "tasks": [],
            "created_date": "2019-12-26T12:07:18.301Z",
            "__v": 0
        },
        {
            "status": false,
            "_id": "5e04a27692928701258b9b06",
            "group_id": "5df8aaae2f85481f6e31db59",
            "date": "2019-12-30T00:00:00.000Z",
            "title": "abc",
            "priority": 5,
            "description": "just a description",
            "tasks": [],
            "created_date": "2019-12-26T12:07:18.301Z",
            "__v": 0
        }
    ]
}
    ''';

    Event event = eventFromJson(responseString);

    for (int i = 0; i < event.data.length; i++) {
      mapFetch[event.data[i].date] = [event.data[i].title];
    }

    return mapFetch;
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};

    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        get_bookings_calander +
        "?token=" +
        token +
        "&client_id=" +
        clientId.toString() +
        "&status=3";
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");

    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        Event1 event = event1FromJson(responce.body);
        for (int i = 0; i < event.data.length; i++) {
          mapFetch[event.data[i].date] = [event.data[i].bookings];
        }
      }
    }

    //await Future.delayed(const Duration(seconds: 3), () {});

    // String responseString1 = '''
    // {
    // "result": 1,
    // "message": "All Bookings",
    // "data":[{"date": "2021-06-11","bookings": [{ "id": "1", "title": "title1","description":"desc1" }, { "id": "2", "title": "title2","description":"desc2" },{ "id": "3", "title": "title3","description":"desc3" }]},
    // {"date": "2021-06-12","bookings": [{ "id": "1", "title": "title11","description":"desc111" }, { "id": "2", "title": "title22","description":"desc222" },{ "id": "3", "title": "title33","description":"desc333" }]}
    //   ]
    // }
    // ''';

    // Event1 event = event1FromJson(responseString1);

    // for (int i = 0; i < event.data.length; i++) {
    //   mapFetch[event.data[i].date] = [event.data[i].bookings];
    // }

    return mapFetch;
  }

  static Map<DateTime, List> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, List> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  static Future<Map<DateTime, List>> fetchBooking() async {
    //http://192.168.0.112:8383/redcircle/web/api/get_bookings.php?token=rb115oc-Rcas|Kredcircleu&client_id=18&status=3
    // String url = root +
    //     "/" +
    //     const_get_bookings +
    //     "?token=" +
    //     token +
    //     "&client_id=" +
    //     clientId.toString() +
    //     "&status=3";
    // print(url);
    // dynamic responce =
    //     await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    // print(" ${responce.body}");

    Map<String, dynamic> res5 = jsonDecode(calendarBookingval1);
    return Map<DateTime, List<dynamic>>.from(decodeMap(res5));

    Map<String, dynamic> res2 = jsonDecode(calendarBookingval);
    Map<String, dynamic> res4 = jsonDecode(res2['data'].toString());

    return Map<DateTime, List<dynamic>>.from(decodeMap(res4));

    // if (responce.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(calendarBookingval); //responce.body
    if (res['result'] == 1) {
      // List<Booking> services =
      //     (res['data'] as List).map((i) => CalanderBooking.fromJson(i)).toList();

      // var map2 = {};
      // list.forEach((customer) => map2[customer.name] = customer.age);

      print(res['data'].toString());
      Map<String, dynamic> res1 =
          jsonDecode(res['data'].toString()); //responce.body

      Map<DateTime, List> _events = Map<DateTime, List>.from(decodeMap(res1));
      return _events;
      // _events = Map<DateTime, List<dynamic>>.from(
      //     decodeMap(json.decode(res.toString() ?? "{}")));

      // return CalanderBooking1.fromJson(res);

      // List<CalanderBooking> books = (res['data'] as List)
      //     .map((i) => CalanderBooking.fromJson(i))
      //     .toList();
      // Map<DateTime, dynamic> map1 =
      //     Map.fromIterable(books, key: (e) => e.date, value: (e) => e.bookings);

      // Map<String, List> calanderBookings = (res['data'] as List).map((i) => CalanderBooking.fromJson(i)).toList();
      // Map<DateTime, dynamic> ress;
      // Map<DateTime, List> bs = (res['data'] as List).map((i) {
      //   Map<DateTime, dynamic> res = jsonDecode(i);
      //   ress.putIfAbsent(key, () => null)

      //   return ress;
      // });
      // return map1;
    } else {
      return Map<DateTime, List>.from(decodeMap({}));
    }

    // }
    // throw Exception('Failed to load');
  }

  Map<DateTime, List> _events = {};
  Future<Map<DateTime, List>> futureBooking;
  @override
  void initState() {
    getTask1().then((val) {
      setState(() {
        _events = val;

        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);
        _selectedDay = formatter.format(date);
        _selectedEvents = _events[date] ?? [];

        // _calendarController.setSelectedDay(DateTime.now(),
        //     isProgrammatic: true);
        // _calendarController.setSelectedDay(DateTime.now(), runCallback: true);
      });
    });
    //     void _selectDay(DateTime day) {
    //   setState(() {
    //     widget.calendarController.setSelectedDay(day, isProgrammatic: false);
    //     _selectedDayCallback(day);
    //   });
    // }
    // _calendarController.setSelectedDay(DateTime.now(), isProgrammatic: true);

    // setState(() {
    //   _events = val;
    //   _selectedDay = formatter.format(DateTime.now());
    //   _selectedEvents = _events[DateTime.now()] ?? [];
    //   _calendarController.setCalendarFormat((_selectedEvents.length != 0)
    //       ? CalendarFormat.week
    //       : CalendarFormat.month);
    //   _animationController.forward(from: 1.0);
    //   // _calendarController.setSelectedDay(DateTime.now(),
    //   //     isProgrammatic: true);
    // });

    // _selectedEvents = [];
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    _selectedEvents = _events[date] ?? [];

    // final nowDay = DateTime.now();
    // _selectedEvents = _events[nowDay] ?? [];
    _selectedDay = formatter.format(DateTime.now());

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedDay = formatter.format(day);
      _selectedEvents = events;
      _calendarController.setCalendarFormat((_selectedEvents.length != 0)
          ? CalendarFormat.week
          : CalendarFormat.month);
    });
    print(monthFormat);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                getProportionateScreenWidth(SizeConfig.screenWidth * 0.03)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Switch out 2 lines below to play with TableCalendar's settings
            //-----------------------
            // _buildTableCalendar(),
            _buildTableCalendarWithBuilders(),
            // const SizedBox(height: 8.0),
            // _buildButtons(),
            // const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, bottom: 8.0, top: 20),
              child: Text(
                "",
                //_selectedDay.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: _buildEventList())),
          ],
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  // Widget _buildTableCalendar() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.black, // Color.fromRGBO(28, 28, 30, 1),
  //       border: Border.all(color: KBorderColor.withOpacity(0.7), width: 0.4),
  //       // boxShadow: [
  //       //   BoxShadow(
  //       //     offset: Offset(0, -15),
  //       //     blurRadius: 20,
  //       //     color: Color(0xFFDADADA).withOpacity(0.15),
  //       //   ),
  //       // ],
  //       borderRadius: BorderRadius.all(Radius.circular(8)),
  //     ),
  //     child: TableCalendar(
  //       calendarController: _calendarController,
  //       events: _events,
  //       // holidays: _holidays,
  //       startingDayOfWeek: StartingDayOfWeek.monday,
  //       calendarStyle: CalendarStyle(
  //         // outsideHolidayStyle: TextStyle(color: Colors.orange),
  //         // outsideStyle: TextStyle(color: Colors.yellow),
  //         // outsideWeekendStyle: TextStyle(color: Colors.black),
  //         selectedColor: kPrimaryColor,
  //         todayColor: Colors.transparent,
  //         weekdayStyle: TextStyle(color: Colors.white),
  //         eventDayStyle: TextStyle(color: Colors.white),
  //         holidayStyle: TextStyle(color: Colors.white),
  //         weekendStyle: TextStyle(color: Colors.white),
  //         selectedStyle:
  //             TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         markersColor: Colors.transparent,
  //         outsideDaysVisible: false,
  //       ),

  //       headerStyle: HeaderStyle(
  //         centerHeaderTitle: true,
  //         titleTextStyle: TextStyle(color: Colors.white),
  //         formatButtonShowsNext: true,
  //         formatButtonVisible: false,
  //         formatButtonTextStyle:
  //             TextStyle().copyWith(color: Colors.black, fontSize: 15.0),
  //         formatButtonDecoration: BoxDecoration(
  //           color: Colors.deepOrange[400],
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //       ),
  //       onDaySelected: _onDaySelected,
  //       onVisibleDaysChanged: _onVisibleDaysChanged,
  //       onCalendarCreated: _onCalendarCreated,
  //     ),
  //   );
  // }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return Center(
      child: Container(
        width: getProportionateScreenWidth(320),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: KBorderColor.withOpacity(0.7), width: 0.4),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: TableCalendar(
          // locale: 'pl_PL',
          calendarController: _calendarController,
          events: _events,
          // holidays: _holidays,

          initialCalendarFormat:
              monthFormat ? CalendarFormat.week : CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
            CalendarFormat.week: '',
          },
          calendarStyle: CalendarStyle(
            // outsideHolidayStyle: TextStyle(color: Colors.orange),
            // outsideStyle: TextStyle(color: Colors.yellow),
            // outsideWeekendStyle: TextStyle(color: Colors.black),
            selectedColor: kPrimaryColor,
            todayColor: Colors.transparent,
            weekdayStyle: TextStyle(color: Colors.white),
            eventDayStyle: TextStyle(color: Colors.white),
            holidayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white),
            selectedStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            markersColor: Colors.transparent,
            outsideDaysVisible: false,
          ),
          // calendarStyle: CalendarStyle(
          //   outsideDaysVisible: false,
          //   weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
          //   holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
          // ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle().copyWith(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold),
            weekendStyle: TextStyle().copyWith(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),

          // headerStyle: HeaderStyle(
          //   centerHeaderTitle: true,
          //   titleTextStyle: TextStyle(color: Colors.white),
          //   formatButtonShowsNext: true,
          //   formatButtonVisible: false,
          //   formatButtonTextStyle:
          //       TextStyle().copyWith(color: Colors.black, fontSize: 15.0),
          //   formatButtonDecoration: BoxDecoration(
          //     color: Colors.deepOrange[400],
          //     borderRadius: BorderRadius.circular(16.0),
          //   ),
          // ),

          headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
              formatButtonShowsNext: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: kPrimaryColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: kPrimaryColor,
              ),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold)),
          builders: CalendarBuilders(
            // selectedDayBuilder: (context, date, _) {
            //   return FadeTransition(
            //     opacity:
            //         Tween(begin: 0.0, end: 1.0).animate(_animationController),
            //     child: Container(
            //       margin: const EdgeInsets.all(4.0),
            //       padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            //       color: Colors.deepOrange[300],
            //       width: 100,
            //       height: 100,
            //       child: Text(
            //         '${date.day}',
            //         style: TextStyle().copyWith(fontSize: 16.0),
            //       ),
            //     ),
            //   );
            // },
            // todayDayBuilder: (context, date, _) {
            //   return Container(
            //     margin: const EdgeInsets.all(4.0),
            //     padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            //     color: Colors.amber[400],
            //     width: 100,
            //     height: 100,
            //     child: Text(
            //       '${date.day}',
            //       style: TextStyle().copyWith(fontSize: 16.0),
            //     ),
            //   );
            // },
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];
              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    bottom: 6,
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }
              // if (holidays.isNotEmpty) {
              //   children.add(
              //     Positioned(
              //       right: -2,
              //       top: -2,
              //       child: _buildHolidaysMarker(),
              //     ),
              //   );
              // }
              return children;
            },
          ),
          onDaySelected: (date, events, holidays) {
            _onDaySelected(date, events, holidays);
            _animationController.forward(from: 1.0);
          },
          onVisibleDaysChanged: _onVisibleDaysChanged,
          onCalendarCreated: _onCalendarCreated,
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        border: Border.all(color: KBorderColor, width: 1),
        shape: BoxShape.circle,
        // color: _calendarController.isSelected(date)
        //     ? Colors.brown[500]
        //     : _calendarController.isToday(date)
        //         ? Colors.brown[300]
        //         : Colors.blue[400],
      ),
      width: 30, //39.0,
      height: 30, //39.0,
      child: Center(
        child: Text(
          '${date.day}', //${events.length}
          style: TextStyle().copyWith(
            color: Colors.transparent,
            // fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    List<Booking> calendar = [];
    (_selectedEvents).map((i) {
      print(i);
      List<Booking>.from(i.map((j) {
        print(j);
        calendar.add(Booking.fromJson(j));
      })).toList();
    }).toList();

    return new ListView.builder(
        itemCount: calendar.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return RequestCard(
              id: calendar[index].id,
              title: calendar[index].title,
              mainImage: calendar[index].mainImg,
              description: calendar[index].description,
              subtitle: calendar[index].subtitle,
              onSyncCalendar: () {
                final add_2_calendar.Event event = add_2_calendar.Event(
                  title: calendar[index].title,
                  description: '',
                  location: '',
                  startDate: calendar[index].startDate,
                  endDate: calendar[index].endDate,
                  iosParams: add_2_calendar.IOSParams(
                    reminder: Duration(
                        /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                  ),
                  androidParams: add_2_calendar.AndroidParams(
                    emailInvites: [], // on Android, you can add invite emails to your event.
                  ),
                );
                add_2_calendar.Add2Calendar.addEvent2Cal(event);
              },
              onTapCard: () async {
                (calendar[index].isOffer == null ||
                        calendar[index].isOffer == "0")
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDescription(
                              productId: calendar[index].listingId),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfferDescription(
                            productId: calendar[index].listingId,
                          ),
                        ));
              });
        });
  }
}
