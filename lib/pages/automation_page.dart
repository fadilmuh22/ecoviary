import 'package:ecoviary/components/automation_card.dart';
import 'package:ecoviary/components/automation_form.dart';
import 'package:ecoviary/models/automations_model.dart';
import 'package:ecoviary/services/realtime_database.dart';
import 'package:flutter/material.dart';

class AutomationPage extends StatefulWidget {
  const AutomationPage({super.key});

  @override
  State<AutomationPage> createState() => _AutomationPageState();
}

class _AutomationPageState extends State<AutomationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'List',
            ),
            Tab(
              text: 'Create',
            ),
          ],
          labelColor: Colors.black,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AutomationList(),
              AutomationForm(),
            ],
          ),
        ),
      ],
    );
  }
}

class AutomationList extends StatelessWidget {
  const AutomationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                Map<String, dynamic>.from(
                  automations.values.elementAt(index) as Map,
                ),
              );

              return AutomationCard(automation: automation);
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
