import 'package:ecoviary/data/providers/form_providers.dart';
import 'package:ecoviary/data/providers/ui_providers.dart';
import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';

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
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          var automations =
              firebaseObjectToAutomationsList(snapshot.data!.snapshot.value);

          return ListView.builder(
            itemCount: automations.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              return AutomationCard(
                automation: automations.elementAt(index),
                onEdit: (value) {
                  ref.read(automationFormProvider).setAutomations(value);
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
