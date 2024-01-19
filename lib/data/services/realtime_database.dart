import 'package:firebase_database/firebase_database.dart';

import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/models/controls_model.dart';
import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/models/users_model.dart';
import 'package:ecoviary/data/models/sensors_model.dart';

enum Collections { users, sensors, controls, coops, automations }

extension CollectionsRef on Collections {
  DatabaseReference get ref {
    return RealtimeDatabase.ref.child(name);
  }
}

class RealtimeDatabase {
  static RealtimeDatabase? _instance;

  RealtimeDatabase._();

  factory RealtimeDatabase() {
    _instance ??= RealtimeDatabase._();
    return _instance!;
  }

  static DatabaseReference get ref => FirebaseDatabase.instance.ref();

  static Future<void> write<T extends Object>({
    required Collections key,
    required T data,
  }) async {
    try {
      await ref.child(key.name).set(data);
    } catch (e) {
      rethrow;
    }
  }

  // check if collections exist, if not, create collections
  static Future<void> initialize() async {
    var users = await Collections.users.ref.get();
    if (!users.exists) {
      write(
        key: Collections.users,
        data: Users.defaultValues().toJson(),
      );
    }

    var sensors = await Collections.sensors.ref.get();
    if (!sensors.exists) {
      write(
        key: Collections.sensors,
        data: Sensors.defaultValues().toJson(),
      );
    }

    var controls = await Collections.controls.ref.get();
    if (!controls.exists) {
      write(
        key: Collections.controls,
        data: Controls.defaultValues().toJson(),
      );
    }

    var coops = await Collections.coops.ref.get();
    if (!coops.exists) {
      write(
        key: Collections.coops,
        data: Coops.defaultValues().toJson(),
      );
    }

    var automations = await Collections.automations.ref.get();
    if (!automations.exists) {
      Collections.automations.ref
          .push()
          .set(Automations.defaultValues().toJson());
    }
  }
}
