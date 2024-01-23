import 'package:ecoviary/data/providers/form_providers.dart';
import 'package:ecoviary/ui/pages/coops_page.dart';
import 'package:flutter/material.dart';

import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/monitoring_view.dart';
import 'package:ecoviary/ui/components/coops/coop_card.dart';
import 'package:ecoviary/ui/components/coops/coop_dropdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        const SizedBox(height: 16),
        const MonitoringView(),
        const SizedBox(height: 16),
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
                        child: FilledButton(
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
