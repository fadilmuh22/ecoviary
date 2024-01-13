import 'package:ecoviary/models/controls_model.dart';
import 'package:ecoviary/services/realtime_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  Future<void> _handleControls(
      BuildContext context, Map<String, dynamic> valueToUpdate) async {
    try {
      await Collections.controls.ref.update(valueToUpdate
        ..removeWhere(
            (dynamic key, dynamic value) => key == null || value == null));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        StreamBuilder<DatabaseEvent>(
            stream: Collections.controls.ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var control = Controls.fromJson(Map<String, dynamic>.from(
                    snapshot.data!.snapshot.value as Map));
                return Column(
                  children: [
                    ListTile(
                      title: const Text('Light'),
                      trailing: Switch(
                        value: control.light ?? false,
                        onChanged: (bool value) {
                          _handleControls(
                              context, Controls(light: value).toJson());
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Disinfectant'),
                      trailing: Switch(
                        value: control.disinfectant ?? false,
                        onChanged: (bool value) {
                          _handleControls(
                              context, Controls(disinfectant: value).toJson());
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Water'),
                      trailing: Switch(
                        value: control.water ?? false,
                        onChanged: (bool value) {
                          _handleControls(
                              context, Controls(water: value).toJson());
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Column();
            })
      ],
    );
  }
}
