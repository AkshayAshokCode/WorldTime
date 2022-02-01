import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response =
          await get(Uri.http('worldtimeapi.org', '/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //get properties from data
      String dateTime = data['datetime'].substring(0, 25);
      //  String offset=data['utc_offset'].substring(1,3);

      // create DateTime object
      DateTime now = DateTime.parse(dateTime);
      //  now=now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error: $e');
      time = 'could not get time details';
    }
  }
}
