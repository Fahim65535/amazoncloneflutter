import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/barrel_config.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  //page controller
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //tab ontapped
  onTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage == page;
    });
  }

  @override
  void initState() {
    CloudFirestore().getNameAndAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: PageView(
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            child: TabBar(
              onTap: onTapped,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: activeCyanColor, width: 4))),
              tabs: [
                Tab(
                  child: Icon(Icons.home_outlined,
                      color: currentPage == 0 ? activeCyanColor : Colors.black),
                ),
                Tab(
                  child: Icon(Icons.account_circle_outlined,
                      color: currentPage == 1 ? activeCyanColor : Colors.black),
                ),
                Tab(
                  child: Icon(Icons.shopping_cart_outlined,
                      color: currentPage == 2 ? activeCyanColor : Colors.black),
                ),
                Tab(
                  child: Icon(Icons.menu,
                      color: currentPage == 3 ? activeCyanColor : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
