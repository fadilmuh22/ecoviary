import 'package:flutter/material.dart';

import 'package:ecoviary/utils/utils.dart';
import 'package:ecoviary/data/models/sensors_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/sensor_card.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Collections.sensors.ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          var sensor = Sensors.fromJson(
              Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monitoring Sanitasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SensorCard(
                    title: 'Suhu',
                    value: formatTemperature(sensor.temperature),
                    description: sensor.getSensorDescription(),
                    icon: Icons.thermostat_rounded,
                    iconColor: Theme.of(context).colorScheme.inversePrimary,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SensorCard(
                    title: 'Kelembapan',
                    value: formatPercentage(sensor.humidity),
                    description: sensor.getSensorDescription(),
                    icon: Icons.water_drop_rounded,
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SensorCard(
                    title: 'Amonia',
                    value: formatPercentage(sensor.amonia),
                    description: sensor.getSensorDescription(),
                    icon: Icons.warning_rounded,
                    iconColor: Theme.of(context).colorScheme.error,
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                  ),
                ],
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
