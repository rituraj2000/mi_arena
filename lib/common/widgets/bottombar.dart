import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:mi_arena/constants/constants.dart';

class Bottombar extends StatefulWidget {
  static const String route = "/actual-home";

  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _page = 0;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  static const double bottomBarWidth = 50;
  static const double bottomBarBorderWith = 5;
  static const double bottomBarHeight = 50;

  List<Widget> pages = [
    const Center(
      child: Text('Home Page'),
    ),
    const Center(
      child: Text('Cart Page'),
    ),
    const Center(
      child: Text('Requests Page'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariable.xiaomiwhiteprimary,
        unselectedItemColor: Colors.grey,
        backgroundColor: GlobalVariable.xiaomiwhiteprimary,
        iconSize: 20,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              height: bottomBarHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _page == 0
                    ? GlobalVariable.xiaomiorangeprimary
                    : GlobalVariable.xiaomiwhiteprimary,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            label: '',
          ),

          //Account
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              height: bottomBarHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _page == 1
                    ? GlobalVariable.xiaomiorangeprimary
                    : GlobalVariable.xiaomiwhiteprimary,
              ),
              child: const Icon(
                Icons.document_scanner,
              ),
            ),
            label: '',
          ),

          //Cart
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              height: bottomBarHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _page == 2
                    ? GlobalVariable.xiaomiorangeprimary
                    : GlobalVariable.xiaomiwhiteprimary,
              ),
              child: Badge(
                elevation: 0,
                badgeContent: const Text("2"),
                badgeColor: Colors.white,
                child: const Icon(
                  Icons.inventory_2_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
