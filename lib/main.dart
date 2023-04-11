import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'screen/ekle.dart';
import 'screen/guncelle.dart';
import 'screen/listele.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Notch Bottom Bar',
      theme: ThemeData(
    primaryColor: Colors.black,
  ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    const Ekle(),
    const Listele(),
    const Guncelle()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
             
            backgroundColor: Colors.black, title: const Text("Sqflite")),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.black87,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  itemLabel: 'Ekle',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.update,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.update,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
