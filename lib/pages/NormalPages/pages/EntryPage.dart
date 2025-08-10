// flutter
import 'package:flutter/material.dart';

// pages
import 'package:kikoeru/pages/HomePage/pages/DefaultPages.dart';

// widget
import 'package:kikoeru/pages/NormalPages/widgets/HomePageTitle.dart';
import 'package:kikoeru/pages/NormalPages/widgets/DrawerWidget.dart';

// function
import 'package:kikoeru/pages/NormalPages/logic/EntryPageEvent.dart';

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
    _tabController.addListener(() => handleTabSelection(_tabController));
  }

  @override
  void dispose() {
    _tabController.removeListener(() => handleTabSelection(_tabController));
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
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
            onPressed: () => toggleTheme(context),
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
