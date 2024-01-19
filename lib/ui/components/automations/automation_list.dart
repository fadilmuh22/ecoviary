import 'package:ecoviary/data/providers/ui_providers.dart';
import 'package:flutter/material.dart';

import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/automations/automation_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutomationList extends ConsumerWidget {
  const AutomationList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: Collections.automations.ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var automations = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>);

          return ListView.builder(
            itemCount: automations.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              Automations? automation = Automations.fromJson(
                Map<String, dynamic>.from({
                  'id': automations.keys.elementAt(index),
                  ...automations.values.elementAt(index) as Map,
                }),
              );

              return AutomationCard(
                automation: automation,
                onEdit: (value) {
                  ref.read(automationsTabIndexProvider).changeTab(1);
                },
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
