import 'package:ecoviary/models/sensors_model.dart';
import 'package:ecoviary/services/realtime_database.dart';
import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        StreamBuilder(
          stream: Collections.sensors.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var sensor = Sensors.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));

              return Column(
                children: [
                  ListTile(
                    title: const Text('Temperature'),
                    trailing: Text('${sensor.temperature}°C'),
                  ),
                  ListTile(
                    title: const Text('Humidity'),
                    trailing: Text(formatPercentage(sensor.humidity)),
                  ),
                  ListTile(
                    title: const Text('Amonia'),
                    trailing: Text(formatPercentage(sensor.amonia)),
                  ),
                ],
              );
            }
            return const Column();
          },
        )
      ],
    );
  }
}
