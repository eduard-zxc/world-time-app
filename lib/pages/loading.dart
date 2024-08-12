import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpWordTime() async {
    WorldTime instance = WorldTime(
        location: 'Chisinau', flag: 'germany.png', url: 'Europe/Chisinau');
    await instance.getTime();
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDay': instance.isDay,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      setUpWordTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
