// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, unused_element
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/blocs/video_bloc/video_state.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/helper/constants/dimensions.dart';
import 'package:task009/helper/constants/string_helper.dart';
import 'package:task009/presentation/screens/video_screen/components/play_video_widget.dart';
import 'package:task009/presentation/screens/video_screen/components/video_picker_btn.dart';
import 'package:task009/presentation/widgets/drawer_widget.dart';
import 'package:task009/presentation/widgets/text_widget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideoBloc>(context);
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: TextWidgets(txt: StringHelper.VIDEO_SCREEN),
        ),
        body: SafeArea(
          child: BlocConsumer<VideoBloc, VideoStates>(
            listener: (context, state) {
              if (state.isDenied == true) {
                dialogBox.showAlertDialog(context,
                    yesButtonTaped: () => Navigator.pop(context),
                    noBtnPress: () => Navigator.pop(context),
                    action: StringHelper.PERMISSION,
                    titleContent: StringHelper.PERMISSION_DENIED);
              } else if (state.isPermanentDenied == true) {
                dialogBox.showAlertDialog(context,
                    yesButtonTaped: () =>
                        Navigator.pop(context, openAppSettings()),
                    noBtnPress: () => Navigator.pop(context),
                    action: StringHelper.PERMISSION,
                    titleContent:
                        '${StringHelper.PERMISSION_PERMANENT_DENIED}\n${StringHelper.OPEN}');
              }
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<VideoBloc, VideoStates>(
                      builder: (context, state) {
                        if (state.video != null) {
                          return Container(
                            height: SizeConfig.screenHeight /
                                Dimensions.D_2 *
                                Dimensions.D_1,
                            child: VideoWidget(
                                img: state.thumbnailImg,
                                video: state.video,
                                asp_ratio: state.video!.value.aspectRatio),
                          );
                        }

                        if (state.video == null) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT),
                            child: TextWidgets(txt: StringHelper.NO_FILE),
                          ));
                        }
                        return Spacer();
                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          vertical: Dimensions.FONT_SIZE_EXTRA_SMALL),
                      child: VideoPicker(bloc: bloc),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
