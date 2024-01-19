import 'package:flutter/material.dart';

import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/models/sensors_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/sensor_card.dart';
import 'package:ecoviary/ui/components/coop_card.dart';
import 'package:ecoviary/ui/components/coops_dropdown.dart';
import 'package:ecoviary/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Bengras Farm'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: CoopsDropdown(),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            )
          ],
        ),
        const SizedBox(height: 24),
        StreamBuilder(
          stream: Collections.sensors.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var sensor = Sensors.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));

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
                        iconColor: Theme.of(context).colorScheme.primary,
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
            return const Column();
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Data Kandang',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        StreamBuilder(
          stream: Collections.coops.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var coop = Coops.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));
              return CoopCard(coop: coop);
            }
            return Container();
          },
        ),
      ],
    );
  }
}
