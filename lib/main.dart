import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task009/blocs/audio_bloc/audio_bloc.dart';
import 'package:task009/blocs/drawer_bloc/bloc.dart';
import 'package:task009/blocs/image_bloc/image_bloc.dart';
import 'package:task009/blocs/video_bloc/video_bloc.dart';
import 'package:task009/helper/config/size_config.dart';
import 'package:task009/helper/constants/color_helper.dart';
import 'package:task009/helper/constants/const.dart';
import 'package:task009/presentation/routes/route_generator.dart';
import 'package:task009/repository/audio_repo/audio_reposirty_implements.dart';
import 'package:task009/repository/image_repo/image_repository.dart';
import 'package:task009/repository/video_repo/video_implements.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiBlocProvider(
              providers: [
                BlocProvider<NavigationCubit>(
                  create: (context) => NavigationCubit(),
                ),
                BlocProvider<VideoBloc>(
                    create: ((context) => VideoBloc(
                          getVideRepo: GetVideoRepo(),
                        ))),
                BlocProvider<ImageBloc>(
                    create: ((context) =>
                        ImageBloc(imgRepo: ImageRepository()))),
                BlocProvider<AudioBlocs>(
                    create: ((context) =>
                        AudioBlocs(audioRepo: AudioRepository()))),
              ],
              child: MaterialApp(
                theme: ThemeData(
                    primaryColor: ColorHelper.K_redAccent,
                    primarySwatch: ColorHelper.generateMaterialColor(
                        ColorHelper.K_redAccent),
                    iconTheme: IconThemeData(color: ColorHelper.K_redAccent)),
                navigatorKey: navigatorKey,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        );
      },
    );
  }
}
