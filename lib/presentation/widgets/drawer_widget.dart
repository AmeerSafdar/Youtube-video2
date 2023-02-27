// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task009/blocs/drawer_bloc/bloc.dart';
import 'package:task009/helper/constants/color_helper.dart';
import 'package:task009/helper/constants/icon_helper.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/helper/constants/image_helper.dart';
import 'package:task009/presentation/widgets/text_widget.dart';
import 'list_tile_widgets.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NavigationCubit>(context);

    return Drawer(
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: ColorHelper.K_redAccent),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorHelper.K_white,
                      radius: 45,
                      backgroundImage: AssetImage(ImageHelper.picture),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: TextWidgets(txt: StringHelper.RANDOM_EMAIL)),
                  ],
                ),
              ),
              ListTileWidgets(
                icon: IconHelper.HOME_ICON,
                tapped: () {
                  Navigator.pop(context);
                  if (state.navbarItem != NavbarItem.main) {
                    bloc.getNavBarItem(NavbarItem.main);
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                txt: StringHelper.MAIN_SCREEN,
              ),
              ListTileWidgets(
                icon: IconHelper.VIDEO_ICON,
                tapped: () {
                  bloc.getNavBarItem(NavbarItem.video);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/videoscreen');
                },
                txt: StringHelper.VIDEO_SCREEN,
              ),
              ListTileWidgets(
                icon: IconHelper.IMAGE_ICON,
                tapped: () {
                  bloc.getNavBarItem(NavbarItem.image);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/imagescreen');
                },
                txt: StringHelper.IMAGE_SCREEN,
              ),
              ListTileWidgets(
                icon: IconHelper.AUDIO_ICON,
                tapped: () {
                  bloc.getNavBarItem(NavbarItem.audio);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/audioscreen');
                },
                txt: StringHelper.AUDIO_SCREEN,
              ),
            ],
          );
        },
      ),
    );
  }
}
