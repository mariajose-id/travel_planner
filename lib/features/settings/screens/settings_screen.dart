import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';
import 'package:travel_planner/shared/widgets/app_tab_bar.dart';
import 'package:travel_planner/features/settings/presentation/widgets/profile_tab.dart';
import 'package:travel_planner/features/settings/presentation/widgets/preferences_tab.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.goNamed(AppRoutes.home),
            ),
            title: Text(
              'Settings',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: const SafeArea(child: SettingsTabView()),
        ),
      ],
    );
  }
}

class SettingsTabView extends ConsumerStatefulWidget {
  const SettingsTabView({super.key});

  @override
  ConsumerState<SettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends ConsumerState<SettingsTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: AppTabBar(
              controller: _tabController,
              currentIndex: _tabController.index,
              onTap: (index) {
                _tabController.animateTo(index);
                setState(() {});
              },
              tabs: const ['Profile', 'Preferences'],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const [ProfileTab(), PreferencesTab()],
      ),
    );
  }
}
