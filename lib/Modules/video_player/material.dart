import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/cubit/cubit.dart';
import 'package:video_player/video_player.dart';

import '/Modules/video_player/Questions.dart';
import '/Modules/video_player/details.dart';
import '/Modules/video_player/lectures.dart';
import '/Shared/local/cache_helper.dart';
import '/models/courses_models/one_user_course.dart';
import '/models/materials/one_material_model.dart';
import '../../cubit/states.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    Key? key,
    required this.materials,
    required this.initialUrl,
    //  required this.playingIndex,
    this.comments,
    required this.courseId,
    this.cubitIs,
  }) : super(key: key);

  final OneMaterialModel materials;
  final List<Comments>? comments;
  final String initialUrl;
  final cubitIs;

  // final int playingIndex;
  final String courseId;

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  var size, Height, width;

  var controller;
  var videoPlayerController;

  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.initialUrl);
    await Future.wait([_videoPlayerController1.initialize()]).then((value) {
      _createChewieController();
      setState(() {});
    }).catchError((e) {
      if (kDebugMode) {
        print("_videoPlayerController1.initialize() error is : $e");
      }
    });
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      isLive: false,
      aspectRatio: 16 / 9,
      allowMuting: true,
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      hideControlsTimer: const Duration(seconds: 2),
      overlay: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.5),
                child: Text(
                  '${CacheHelper.getData(key: 'email')}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 15),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                color: Colors.white.withOpacity(0.5),
                child: Text(
                  'Id:  ${CacheHelper.getData(key: 'uid')}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Height = size.height;
    width = size.width;
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Height / 3
                          : Height,
                      width: double.infinity,
                      child: _chewieController != null &&
                              _chewieController!
                                  .videoPlayerController.value.isInitialized
                          ? Chewie(controller: _chewieController!)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text('Loading'),
                              ],
                            ),
                    ),
                    if (MediaQuery.of(context).orientation ==
                        Orientation.portrait)
                      SizedBox(
                        height: 75,
                        child: AppBar(
                          backgroundColor: HexColor('#0029e7'),
                          leading: null,
                          bottom: const TabBar(
                            tabs: [
                              Tab(
                                text: 'Lectures',
                              ),
                              Tab(
                                text: 'Q&A',
                              ),
                              Tab(
                                text: 'Details',
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (MediaQuery.of(context).orientation ==
                        Orientation.portrait)
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Lectures
                            LecturesScreen(
                              courseId: widget.courseId,
                              comments: widget.comments,
                              material: widget.materials,
                              myCubit: widget.cubitIs,
                              //playingIndex: widget.playingIndex,
                            ),
                            // Q&A
                            QAndAScreen(
                                comments: widget.comments,
                                courseId: widget.courseId),
                            // Details
                            DetailsScreen(courseId: widget.courseId),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
