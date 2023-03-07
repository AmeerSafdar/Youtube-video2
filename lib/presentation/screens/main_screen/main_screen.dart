// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_function_declarations_over_variables, must_be_immutable, unused_field, unused_element, avoid_print, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/blocs/video_bloc/video_events.dart';
import 'package:task009/blocs/video_bloc/video_state.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/color_helper.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/helper/constants/icon_helper.dart';
import 'package:task009/helper/constants/screen_percentage.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/helper/constants/videoList.dart';
import 'package:task009/presentation/widgets/drawer_widget.dart';
import 'package:task009/presentation/widgets/text_widget.dart';
import 'package:video_player/video_player.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  final ScrollController controller = ScrollController();
  double offset = 0.0;
  late VideoPlayerController controler;
  // List<VideoPlayerController>? videoControllers;
  @override
  void initState() {
    controller.addListener(_scrollListener);

    // BlocProvider.of<VideoBloc>(context).add(GetVideoList());
    // videoURL.forEach((element) {
    //   urlcontrollers.add(VideoPlayerController.network(element)
    //     ..initialize().then((value) {
    //       _videoPlayerController.setLooping(true);
    //       _videoPlayerController.play();
    //     }));
    // });
    super.initState();
    BlocProvider.of<VideoBloc>(context).add(Scrolling());
    // BlocProvider.of<VideoBloc>(context).add(GetVideoList());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // BlocProvider.of<VideoBloc>(context).add(GetVideoList());
    });
  }

  void init() async {
    // BlocProvider.of<VideoBloc>(context).add(GetVideoList());
  }

  _scrollListener() {
    if (mounted) {
      offset = controller.offset;
    }
    BlocProvider.of<VideoBloc>(context).add(Scrolling());
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
            return state.isScroll != true
                ? Container(
                    child: TextWidgets(txt: ""),
                  )
                : ListView.builder(
                    itemCount: videList.length,
                    controller: controller,
                    addAutomaticKeepAlives: false,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      double vHeight = SizeConfig.screenHeight *
                          ScreenPercentage.SCREEN_SIZE_30;
                      controler = VideoPlayerController.network(videList[0])
                        ..initialize().then((_) {
                          controler.play();
                        });

                      // controler.play();
                      

                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: ColorHelper.K_black,
                            height: vHeight,
                            child: AspectRatio(
                              aspectRatio: controler.value.aspectRatio,
                              child: offset <= (vHeight * index) &&
                                      offset >=
                                          (vHeight * index) -
                                              (SizeConfig.screenHeight -
                                                  2 * vHeight) &&
                                      controler.value.isInitialized == true
                                  ? VideoPlayer(controler)
                                  : Stack(
                                      alignment: Alignment.center,
                                      children: [
                                          Container(
                                            height: vHeight,
                                            width: double.infinity,
                                            color: ColorHelper.K_black,
                                          ),
                                          Positioned(
                                              child: Center(
                                                  child: IconHelper.PLAY_ICON))
                                        ]),
                            ),
                          ),
                          Container(
                            height: Dimensions.D_11,
                          ),
                          index == videList.length - 1
                              ? Container(
                                  height: Dimensions.D_30,
                                )
                              : Container()
                        ],
                      );
                      // VideoPlayerController cntrl = VideoPlayerController
                      //     .network(videosList[index].videoURL!)
                      //   ..initialize();
                      // // print("lenthis ${state.controll!.length}");
                      // // print("lenthis ${urlcontrollers.length}");
                      // double vHeight = SizeConfig.screenHeight *
                      //     ScreenPercentage.SCREEN_SIZE_30;
                      // // _videoPlayerController =
                      // //     VideoPlayerController.network(videoURL[index])..initialize();
                      // // return AspectRatio(
                      // //     aspectRatio: urlcontrollers[index]!.value.aspectRatio,
                      // //     child: urlcontrollers[index]!.value.isInitialized
                      // //         ? Container(
                      // //             child: VideoPlayer(urlcontrollers[index]!),
                      // //           )
                      // //         : Container());
                      // return Container(
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         height: vHeight,
                      //         width: double.infinity,
                      //         color: ColorHelper.K_black,
                      //         child: Container(
                      //           // child: BetterPlayer.network(
                      //           //     betterPlayerConfiguration:
                      //           //         BetterPlayerConfiguration(
                      //           //       aspectRatio: 16 / 9,
                      //           //     ),
                      //           //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
                      //           child: VideoPlayers(
                      //             // img: thumbImgList[index],
                      //             isPositioned: offset <= (vHeight * index) &&
                      //                 offset >=
                      //                     (vHeight * index) -
                      //                         (SizeConfig.screenHeight -
                      //                             2 * vHeight),
                      //             key: ObjectKey(videoURL[index]),
                      //             img: videosList[index].thumbURL,
                      //             video: cntrl,
                      //             url: videosList[index].videoURL,
                      //           ),
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal:
                      //                 Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      //             vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      //         child: Row(
                      //           children: [
                      //             // Container(
                      //             //   padding: EdgeInsets.symmetric(
                      //             //       horizontal:
                      //             //           Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      //             //   child: CircleAvatar(
                      //             //     backgroundImage: MemoryImage(
                      //             //       thumbImgList[index]!,
                      //             //     ),
                      //             //   ),
                      //             // ),
                      //             SizeBoxWidget(
                      //               widths: Dimensions.D_10,
                      //             ),
                      //             // Flexible(
                      //             //   child: TextWidgets(
                      //             //     txt: videoName[index].toString(),
                      //             //     style: CustomTextStyle.songsName,
                      //             //   ),
                      //             // ),
                      //           ],
                      //         ),
                      //       ),
                      //       if (index == videoURL.length)
                      //         SizeBoxWidget(
                      //           heights: Dimensions.D_30,
                      //         )
                      //     ],
                      //   ),
                      // );
                    }));
          },
        ));
  }
}
