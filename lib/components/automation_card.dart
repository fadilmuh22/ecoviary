import 'package:ecoviary/models/automations_model.dart';
import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/intl.dart';

class AutomationCard extends StatelessWidget {
  const AutomationCard({
    super.key,
    required this.automation,
  });

  final Automations automation;

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
                    const PopupMenuItem(child: Text('Edit')),
                    const PopupMenuItem(child: Text('Delete')),
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
