import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const home = 0;
  static const settings = 1;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
    super.onInit();
  }

  void _initNavigation(
      {required PageController pageController, required int currentIndex}) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView(int newIndex) {
    if (_currentIndex.value == newIndex) return;

    _currentIndex.value = newIndex;
    _pageController.jumpToPage(newIndex);
  }
}
