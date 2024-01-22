import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoopCard extends StatelessWidget {
  final Coops coop;

  const CoopCard({
    super.key,
    required this.coop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info, size: 12),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd/mm/yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(coop.date),
                      ),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Umur',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        formatDaysToChickenAge(coop.age),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Betina',
                    ),
                    Text(
                      '${coop.totalHen}',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jantan',
                    ),
                    Text(
                      '${coop.totalRooster}',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jumlah Ayam',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${coop.totalChicken}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
