import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartm/page/data_display_page.dart';
import 'package:smartm/page/guide_page.dart';
import 'package:smartm/page/sprinkler_page.dart';
import 'package:smartm/page/user_page.dart';
import 'package:smartm/shared/theme.dart';
import 'package:fluttericon/entypo_icons.dart';

class MainNavPage extends StatelessWidget {
  const MainNavPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageIndexProvider(),
      child: _MainPage(),
    );
  }
}

class _MainPage extends StatefulWidget {
  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  List<Widget> get pages => [
        DashboardPage(),
        SprinklerPage(),
        GuidePage(),
        UserPage(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/LogoHorizontal.png', height: 40),
        ),
        bottomNavigationBar: Consumer<PageIndexProvider>(
          builder: (context, pageIndexProvider, _) {
            return Container(
              height: 59,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  shadows: const [
                    BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 3.50,
                        offset: Offset(0, 3.50),
                        spreadRadius: 0)
                  ]),
              child: ClipRRect(
                child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: AppTheme.primaryColor,
                    unselectedItemColor: AppTheme.passiveColor,
                    currentIndex: pageIndexProvider.index,
                    onTap: (index) {
                      setState(() {
                        pageIndexProvider.changeIndex(index);
                      });
                    },
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(Entypo.water), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.help), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: "")
                    ]),
              ),
            );
          },
        ),
        body: Consumer<PageIndexProvider>(
          builder: (context, pageIndexProvider, _) {
            if (pageIndexProvider.index >= 0 &&
                pageIndexProvider.index < pages.length) {
              return pages[pageIndexProvider.index];
            } else {
              return Container();
            }
          },
        ));
  }
}

class PageIndexProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void changeIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}
