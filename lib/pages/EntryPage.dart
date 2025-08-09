import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:kikoeru/config/ThemeProvider.dart';

import 'package:kikoeru/widget/EntryPageWidget/HomePageTitle.dart';
import 'package:kikoeru/widget/DrawerWidget/DrawerWidget.dart';

import 'package:kikoeru/pages/HomePage/DefaultPages.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key, required this.title});
  final String title;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleTheme() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.toggleTheme();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      debugPrint('Tab is changing to index: ${_tabController.index}');
    } else if (!_tabController.indexIsChanging) {
      debugPrint('Tab changed to index: ${_tabController.index}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: HomePageTitle(context, widget.title, _searchController),
        leading: IconButton(
          onPressed: () async {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "🔥熱門作品"),
            Tab(text: "🌟 推薦作品"),
            Tab(text: "❤ 我的收藏"),
            Tab(text: "All works"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode_outlined),
            tooltip: 'Toggle Theme',
            onPressed: _toggleTheme,
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: TabBarView(
        controller: _tabController,
        children: [
          PopularWorkPage(),
          RecommandWorkPage(),
          FavoriteWorkPage(),
          AllWorksPage(),
        ],
      ),
    );
  }
}
