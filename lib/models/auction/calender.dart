
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendar {
  Map<String, dynamic>? calenderMapList;
  MyAuctionCalender? myAuctionCalender;

  MyCalendar(
      {Map<String, dynamic>? calenderMapList,
        MyAuctionCalender? myAuctionCalender}) {
    if (calenderMapList != null) {
      calenderMapList = calenderMapList;
    }
    if (myAuctionCalender != null) {
      myAuctionCalender = myAuctionCalender;
    }
  }

  MyCalendar.fromJson(dynamic json) {
    final List<Appointment> appointments = <Appointment>[];


    if (json.isNotEmpty && json.toString()!='[]') {
      calenderMapList = json;

      for (var mKey in json.keys) {
        final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        appointments.add(
          Appointment(
            startTime: dateFormat.parse(mKey),
            endTime: dateFormat.parse(mKey),
            subject: mKey,
          ),
        );
      }
    }

    myAuctionCalender = MyAuctionCalender.fromJson(appointments);
  }
}

class MyAuctionCalender extends CalendarDataSource {
  MyAuctionCalender.fromJson(List<Appointment> source) {
    appointments = source;
  }

  MyAuctionCalender();
}
