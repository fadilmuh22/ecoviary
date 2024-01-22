import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:flutter/material.dart';

class CoopsDropdown extends StatefulWidget {
  const CoopsDropdown({super.key});

  @override
  State<CoopsDropdown> createState() => _CoopsDropdownState();
}

class _CoopsDropdownState extends State<CoopsDropdown> {
  Coops? _selectedCoop;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Collections.coops.ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            var coop = Coops.fromJson(
              Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map),
            );

            return InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Coops>(
                  isDense: true,
                  isExpanded: true,
                  value: _selectedCoop ?? coop,
                  onChanged: (Coops? value) {
                    setState(() {
                      _selectedCoop = value!;
                    });
                  },
                  style: Theme.of(context).textTheme.titleMedium,
                  items: [coop].map<DropdownMenuItem<Coops>>(
                    (Coops value) {
                      return DropdownMenuItem<Coops>(
                        value: value,
                        child: Text(value.name),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
