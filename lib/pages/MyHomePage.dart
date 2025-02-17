import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/config/ThemeProvider.dart';
import 'package:kikoeru/pages/DefaultPages.dart';
import 'package:kikoeru/pages/SearchPage.dart';
import 'package:kikoeru/widget/DrawerWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchWorksPage(
                          type: SearchType.STRING,
                          query: _searchController.text,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
