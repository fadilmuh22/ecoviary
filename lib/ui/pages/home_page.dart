import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/monitoring_view.dart';
import 'package:ecoviary/ui/components/coops/coop_card.dart';
import 'package:ecoviary/ui/components/coops/coop_dropdown.dart';
import 'package:ecoviary/data/models/controls_model.dart';
import 'package:ecoviary/data/providers/form_providers.dart';
import 'package:ecoviary/ui/components/controls/control_status.dart';
import 'package:ecoviary/ui/pages/coops_page.dart';
import 'package:ecoviary/utils/control_icons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    size: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Bengras Farm',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 16,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                child: Icon(
                  Icons.person,
                  size: 12,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CoopsDropdown(),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const MonitoringView(),
        const SizedBox(height: 16),
        const Text(
          'Otomasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder(
          stream: Collections.controls.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              var controls = Controls.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));

              var dateString =
                  DateFormat('dd MMMM yyyy').format(DateTime.now());
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.time_fill,
                        size: 16,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 8),
                      Text(dateString),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ControlStatus(
                        isActive: controls.food!,
                        icon: ControlIcons.silverwareForkKnife,
                        title: 'Pakan',
                      ),
                      ControlStatus(
                        isActive: controls.water!,
                        icon: ControlIcons.cupWater,
                        title: 'Minum',
                      ),
                      ControlStatus(
                        isActive: controls.disinfectant!,
                        icon: ControlIcons.sprinklerFire,
                        title: 'Disinfectant',
                      ),
                    ],
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Data Kandang',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder(
          stream: Collections.coops.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              var coop = Coops.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));
              return Column(
                children: [
                  CoopCard(coop: coop),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ref.read(coopFormProvider).setCoop(coop);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CoopsPage(),
                              ),
                            );
                          },
                          child: const Text('Atur data kandang'),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
