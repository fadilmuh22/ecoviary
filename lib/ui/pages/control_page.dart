import 'dart:async';

import 'package:ecoviary/ui/components/controls/disinfectant_image.dart';
import 'package:ecoviary/ui/components/controls/light_bulb_image.dart';
import 'package:ecoviary/ui/components/controls/water_bucket_image.dart';
import 'package:ecoviary/utils/control_icons.dart';
import 'package:flutter/material.dart';

import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/data/models/controls_model.dart';
import 'package:ecoviary/ui/components/controls/control_item.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage>
    with TickerProviderStateMixin {
  Timer? _controlTimer;
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
    _tabController.addListener(_handleTabSelection);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 0.6,
    );

    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _animateBucket(bool isOn) {
    if (!isOn) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 0.6);
    }
  }

  Future<void> _handleControls(BuildContext context, Controls current,
      Map<String, dynamic> valueToUpdate) async {
    try {
      var isNotLightRunning =
          (current.disinfectant != null && current.disinfectant == true) ||
              (current.water != null && current.water == true) ||
              (current.food != null && current.food == true);
      var isUpdateNotLight = valueToUpdate.keys
          .any((key) => key != 'light' && valueToUpdate[key] == true);

      if (isNotLightRunning && isUpdateNotLight) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tidak bisa mengubah kontrol saat sedang berjalan '),
        ));
        return Future.error(Exception('Kontrol tidak bisa berbarengan'));
      }

      if (_controlTimer != null && _controlTimer!.isActive) {
        _controlTimer!.cancel();
      }

      await Collections.controls.ref.update(valueToUpdate
        ..removeWhere(
            (dynamic key, dynamic value) => key == null || value == null));

      if (isUpdateNotLight) {
        _controlTimer = Timer(const Duration(seconds: 15), () {
          valueToUpdate.updateAll((key, value) => false);
          Collections.controls.ref
              .update(valueToUpdate
                ..removeWhere((dynamic key, dynamic value) =>
                    key == null || value == null))
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Kontrol berhasil dijalankan'),
            ));
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
            ));
          });
        });
      }
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
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          labelColor: Theme.of(context).colorScheme.onPrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
          tabs: const [
            Tab(icon: Icon(ControlIcons.lightbulbOn)),
            Tab(icon: Icon(ControlIcons.sprinklerFire)),
            Tab(icon: Icon(ControlIcons.cupWater)),
          ],
        ),
        StreamBuilder(
          stream: Collections.controls.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              var control = Controls.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));

              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3 -
                      (kToolbarHeight * 2),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ControlItem(
                        icon: LightBulbImage(
                          isOn: control.light ?? false,
                        ),
                        value: control.light ?? false,
                        onChange: (bool value) {
                          return _handleControls(context, control,
                              Controls(light: value).toJson());
                        },
                      ),
                      ControlItem(
                        icon: DisinfectantImage(
                          isOn: control.disinfectant ?? false,
                        ),
                        value: control.disinfectant ?? false,
                        onChange: (bool value) {
                          return _handleControls(context, control,
                              Controls(disinfectant: value).toJson());
                        },
                      ),
                      ControlItem(
                        icon: WaterBucketImage(
                          value: (_animationController.status ==
                                      AnimationStatus.dismissed &&
                                  _animationController.value == 0 &&
                                  (control.water ?? false) == true)
                              ? 0.6
                              : _animationController.value,
                        ),
                        value: control.water ?? false,
                        onChange: (bool value) {
                          return _handleControls(context, control,
                                  Controls(water: value).toJson())
                              .then((_) => _animateBucket(!value));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
