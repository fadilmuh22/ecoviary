import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecoviary/data/providers/form_providers.dart';
import 'package:ecoviary/ui/components/coops/coop_form.dart';

class CoopsPage extends ConsumerStatefulWidget {
  const CoopsPage({super.key});

  @override
  ConsumerState<CoopsPage> createState() => _CoopsPageState();
}

class _CoopsPageState extends ConsumerState<CoopsPage> {
  void _handleSubmit() {
    ref.read(coopFormProvider).submit().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data berhasil disimpan',
          ),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data gagal disimpan',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton(
          onPressed: _handleSubmit,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          child: const Text('Input'),
        ),
      ),
      body: ListView(
        children: [
          AppBar(
            title: const Text(
              'Data Kandang',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          const CoopForm()
        ],
      ),
    );
  }
}
