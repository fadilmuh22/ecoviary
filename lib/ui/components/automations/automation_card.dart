import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ecoviary/data/models/automations_model.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AutomationCard extends StatelessWidget {
  final Function(Automations) onEdit;

  const AutomationCard({
    super.key,
    required this.automation,
    required this.onEdit,
  });

  final Automations automation;

  void _handleDelete(BuildContext context) {
    Collections.automations.ref.child(automation.id).remove().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Automation deleted'),
        ),
      );
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMMM yyyy, hh:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      automation.date,
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => onEdit(automation),
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: () => _handleDelete(context),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: List.generate(
                automation.food.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(
                    automation.food[index].toString(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                automation.water.length,
                (index) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(
                    automation.water[index].toString(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            WeekdaySelector(
              onChanged: (value) {},
              values: automation.disinfectant,
            )
          ],
        ),
      ),
    );
  }
}
