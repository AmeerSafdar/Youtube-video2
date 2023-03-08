// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_function_declarations_over_variables, must_be_immutable, unused_field, unused_element, avoid_print, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/blocs/video_bloc/video_events.dart';
import 'package:task009/blocs/video_bloc/video_state.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/color_helper.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/helper/constants/screen_percentage.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/helper/utils/styles.dart';
import 'package:task009/presentation/screens/main_screen/components/player_widget.dart';
import 'package:task009/presentation/widgets/drawer_widget.dart';
import 'package:task009/presentation/widgets/loading_widget.dart';
import 'package:task009/presentation/widgets/sized_box.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final ScrollController controller = ScrollController();
  double offset = 0.0;
  double vHeight = SizeConfig.screenHeight * ScreenPercentage.SCREEN_SIZE_30;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    controller.addListener(_scrollListener);
    super.initState();
    BlocProvider.of<VideoBloc>(context).add(Scrolling());
  }

  _scrollListener() {
    // if (mounted) {
    offset = controller.offset;
    BlocProvider.of<VideoBloc>(context).add(Play());
    // BlocProvider.of<VideoBloc>(context).add(Scrolling());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(StringHelper.MAIN_SCREEN),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<VideoBloc, VideoStates>(
        builder: (context, state) {
          return (state.controll == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingWidgets(),
                      SizeBoxWidget(
                        heights: Dimensions.D_15,
                      ),
                      TextWidgets(txt: StringHelper.VIDEO_INITIALIZING),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state.controll!.length,
                  controller: controller,
                  addAutomaticKeepAlives: false,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: vHeight,
                                width: double.infinity,
                                color: ColorHelper.K_black,
                                child: Container(
                                  child: VideoPlayers(
                                      img: state.imgLists![index],
                                      isPositioned:
                                          offset <= (vHeight * index) &&
                                              offset >=
                                                  (vHeight * index) -
                                                      (SizeConfig.screenHeight -
                                                          3 * vHeight),
                                      key: ObjectKey(state.controll![index]),
                                      video: state.controll![index]),
                                ),
                              ),
                              Positioned(
                                  bottom: Dimensions.D_8,
                                  right: Dimensions.D_0,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.RADIUS_SMALL)),
                                        color: ColorHelper.K_black),
                                    child: TextWidgets(
                                      txt: printDuration(state
                                          .controll![index].value.duration),
                                      style: CustomTextStyle.textStyles,
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                vertical: Dimensions.PADDING_SIZE_DEFAULT),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(state.imgLists![index]),
                                  ),
                                ),
                                SizeBoxWidget(
                                  widths: Dimensions.D_10,
                                ),
                                Flexible(
                                  child: TextWidgets(
                                    txt: state.controll![index].toString(),
                                    style: CustomTextStyle.songsName,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          index == state.controll!.length - 1
                              ? SizeBoxWidget(
                                  heights: SizeConfig.heightMultiplier *
                                      Dimensions.D_60,
                                )
                              : Container()
                        ],
                      ),
                    );
                  }));
        },
      ),
    );
  }

  String printDuration(Duration? duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration != null) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return '';
  }
}
