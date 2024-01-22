import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:ecoviary/data/models/users_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder<DatabaseEvent>(
          stream: Collections.users.ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              var user = Users.fromJson(Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map));
              return Form(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Name'),
                      trailing: Text(user.name),
                    ),
                    ListTile(
                      title: const Text('Email'),
                      trailing: Text(user.email),
                    ),
                  ],
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
