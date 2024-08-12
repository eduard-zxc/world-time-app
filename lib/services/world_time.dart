import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location = '';
  String time = '';
  String flag = '';
  String url = '';
  bool isDay = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String utcOffset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(hours: int.parse(utcOffset)));

      isDay = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
