import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/config/ThemeProvider.dart';
import 'package:kikoeru/widget/DrawerWidget.dart';
import 'package:kikoeru/pages/allWorks.dart';
import 'package:kikoeru/pages/PopularWork.dart';
import 'package:kikoeru/pages/FavoritePage.dart';
import 'package:kikoeru/pages/RecommandWork.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  void _toggleTheme() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.toggleTheme();
  }

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
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      debugPrint('Tab is changing to index: ${_tabController.index}');
    } else if (!_tabController.indexIsChanging) {
      debugPrint('Tab changed to index: ${_tabController.index}');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
            onPressed: () async {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu)),
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
