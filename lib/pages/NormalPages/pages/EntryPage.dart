// flutter
import "package:flutter/material.dart";

// pages
import "package:kikoeru/pages/HomePage/pages/DefaultPages.dart";

// widget
import "package:kikoeru/pages/NormalPages/widgets/HomePageTitle.dart";
import "package:kikoeru/pages/NormalPages/widgets/DrawerWidget.dart";

// function
import "package:kikoeru/pages/NormalPages/logic/EntryPageEvent.dart";

class EntryPage extends StatefulWidget {
  const EntryPage({super.key, required this.title});

  final String title;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    PopularWorkPage(),
    RecommandWorkPage(),
    FavoriteWorkPage(),
    AllWorksPage(),
  ];
  final List<String> _pageTitles = [
    "🔥熱門作品",
    "🌟 推薦作品",
    "❤ 我的收藏",
    "All works",
  ];

  void setPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
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
        titleSpacing: 0,
        actionsPadding: EdgeInsets.only(right: 4),
        title: HomePageTitle(
            context, _pageTitles[_selectedPageIndex], _searchController),
        leading: IconButton(
          onPressed: () async {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode_outlined),
            tooltip: "Toggle Theme",
            onPressed: () => toggleTheme(context),
          ),
        ],
      ),
      drawer: DrawerWidget(
        selectedPageIndex: _selectedPageIndex,
        setPage: setPage,
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}
