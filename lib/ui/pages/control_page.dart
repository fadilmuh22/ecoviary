import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/data/models/controls_model.dart';
import 'package:ecoviary/ui/components/control_item.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        AppBar(
          title: const Text(
            'Kontrol Sistem',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.lightbulb)),
            Tab(icon: Icon(Icons.local_pizza)),
            Tab(icon: Icon(Icons.water_drop_rounded)),
          ],
        ),
        StreamBuilder<DatabaseEvent>(
          stream: Collections.controls.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var control = Controls.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ControlItem(
                        icon: const Icon(
                          Icons.lightbulb,
                          size: 150,
                        ),
                        value: control.light ?? false,
                        onChange: (bool value) {
                          _handleControls(
                              context, Controls(light: value).toJson());
                        },
                      ),
                      ControlItem(
                        icon: const Icon(
                          Icons.local_pizza,
                          size: 150,
                        ),
                        value: control.disinfectant ?? false,
                        onChange: (bool value) {
                          _handleControls(
                              context, Controls(disinfectant: value).toJson());
                        },
                      ),
                      ControlItem(
                        icon: const Icon(
                          Icons.water_drop_rounded,
                          size: 150,
                        ),
                        value: control.water ?? false,
                        onChange: (bool value) {
                          _handleControls(
                              context, Controls(water: value).toJson());
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
