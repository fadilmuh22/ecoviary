import 'package:ecoviary/data/providers/ui_providers.dart';
import 'package:flutter/material.dart';

import 'package:ecoviary/ui/components/automations/automation_form.dart';
import 'package:ecoviary/ui/components/automations/automation_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutomationPage extends ConsumerStatefulWidget {
  const AutomationPage({super.key});

  @override
  ConsumerState<AutomationPage> createState() => _AutomationPageState();
}

class _AutomationPageState extends ConsumerState<AutomationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    ref.read(automationsTabIndexProvider).changeTab(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(automationsTabIndexProvider, (prev, curr) {
      print('tabIndex ${curr.tabIndex}');
      _tabController.animateTo(curr.tabIndex);
    });

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Daftar Automasi',
            ),
            Tab(
              text: 'Buat Automasi',
            ),
          ],
          labelColor: Colors.black,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              AutomationList(),
              AutomationForm(),
            ],
          ),
        ),
      ],
    );
  }
}
