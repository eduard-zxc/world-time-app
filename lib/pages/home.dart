import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDay'] ? 'assets/day.jpg' : 'assets/night.jpg';
    Color barColor = data['isDay'] ? Colors.blueGrey : Colors.indigo;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'World Time App',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: barColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(
                    () {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDay': result['isDay'],
                        'flag': result['flag'],
                      };
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.blueGrey,
                ),
                label: const Text(
                  'Edit location',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: const TextStyle(fontSize: 28, letterSpacing: 2),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: const TextStyle(fontSize: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
