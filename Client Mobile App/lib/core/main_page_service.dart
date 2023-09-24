import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPageService {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  PersistentTabController get pageController => controller;
}
