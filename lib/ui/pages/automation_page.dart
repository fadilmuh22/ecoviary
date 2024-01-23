import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:flutter/material.dart';

import 'package:ecoviary/ui/components/automations/automation_form.dart';

class AutomationPage extends StatefulWidget {
  const AutomationPage({super.key});

  @override
  State<AutomationPage> createState() => _AutomationPageState();
}

class _AutomationPageState extends State<AutomationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: null,
      children: [
        AppBar(
          title: const Text(
            'Pengaturan Automatis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: Collections.automations.ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var automations = Automations.fromJson(
                    Map<String, dynamic>.from(
                        snapshot.data!.snapshot.value as Map));
                return AutomationForm(automation: automations);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
