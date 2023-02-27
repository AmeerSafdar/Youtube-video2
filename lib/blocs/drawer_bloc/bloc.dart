// ignore_for_file: prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.main, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.main:
        emit(NavigationState(NavbarItem.main, 0));
        break;
      case NavbarItem.video:
        emit(NavigationState(NavbarItem.video, 1));
        break;
      case NavbarItem.image:
        emit(NavigationState(NavbarItem.image, 2));
        break;
      case NavbarItem.audio:
        emit(NavigationState(NavbarItem.audio, 3));
        break;
    }
  }
}

enum NavbarItem { main, video, audio, image }

class NavigationState {
  final NavbarItem navbarItem;
  final int index;

  const NavigationState(this.navbarItem, this.index);
}
