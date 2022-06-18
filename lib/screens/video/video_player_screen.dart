import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter_video_stream/bloc/auth_bloc.dart';
import 'package:flutter_video_stream/bloc/video_bloc.dart';
import 'package:flutter_video_stream/core/app_constants.dart';
import 'package:flutter_video_stream/core/routes.dart';
import 'package:flutter_video_stream/helper/encryption.dart';
import 'package:flutter_video_stream/model/video_model.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';
import 'package:video_player/video_player.dart';
import '../../helper/extensions.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  VideoPlayerController _controller;
  final VideoBloc _bloc = VideoBloc();
  int index = 0;

  bool downloadLoader = false;
  String deCryptFilePath;
  attachVideoTOPlayer() async {
    try {
      if (AppConstants.availableVideos != null &&
          AppConstants.availableVideos.isNotEmpty) {
        if (AppConstants.availableVideos[index].isDownloaded) {
          deCryptFilePath = await EncryptData.decryptfile(
              AppConstants.availableVideos[index].localPathDirectory,
              '${AppConstants.availableVideos[index].title}.mp4');
          _controller = VideoPlayerController.file(File(deCryptFilePath))
            ..initialize().then((_) {
              setState(() {});
            }).onError((error, stackTrace) => CustomWidgets.showSnackbar(
                "Issue with loading video from local storage", context));
        } else {
          _controller = VideoPlayerController.network(
              AppConstants.availableVideos[index].url)
            ..initialize().then((_) {
              setState(() {});
            }).onError((error, stackTrace) => CustomWidgets.showSnackbar(
                "Issue with streaming video", context));
        }
      }
      setState(() {
        _urlKey = UniqueKey();
      });
    } catch (e) {
      CustomWidgets.showSnackbar(e.toString(), context);
    }
  }

  @override
  void initState() {
    super.initState();

    attachVideoTOPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  UniqueKey _urlKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppConstants.isDarkMode ? Colors.blueGrey : const Color(0xffE5E5E5),
      key: _key,
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                  AuthBloc().logout();
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.pushNamed(context, Routes.profile);
                  setState(() {});
                },
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.pushNamed(context, Routes.settings);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: AppConstants.availableVideos[index] == null
            ? const Center(child: Text("Something error occured!"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 233,
                          color: Colors.black,
                          width: double.infinity,
                          child: _controller != null &&
                                  _controller.value.isInitialized
                              ? Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(
                                        _controller,
                                        key: _urlKey,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 40,
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        padding: EdgeInsets.only(
                                          left: _controller.value.isPlaying
                                              ? 24
                                              : 32,
                                          right: 16,
                                        ),
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _controller.value.isPlaying
                                                      ? _controller.pause()
                                                      : _controller.play();
                                                });
                                              },
                                              child: _controller.value.isPlaying
                                                  ? const Icon(
                                                      Icons.pause,
                                                      color: Colors.white,
                                                    )
                                                  : Image.asset(
                                                      'assets/icon/ic_play.png'),
                                            ),
                                            const SizedBox(
                                              width: 17.5,
                                            ),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            VideoProgressIndicator(
                                                          _controller,
                                                          allowScrubbing: true,
                                                          colors:
                                                              const VideoProgressColors(
                                                            playedColor: Color(
                                                                0xff57EE9D),
                                                            backgroundColor:
                                                                Color(
                                                                    0xff525252),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 13.5,
                                                      ),
                                                      TweenAnimationBuilder<
                                                          Duration>(
                                                        tween: Tween(
                                                            begin: _controller
                                                                .value.duration,
                                                            end: Duration.zero),
                                                        duration: _controller
                                                            .value.duration,
                                                        builder: (context,
                                                            value, child) {
                                                          return Text(
                                                            '${_controller.value.position.toMinutesSeconds()} /${_controller.value.duration.toMinutesSeconds()}',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 11.2,
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _controller.seekTo(Duration(
                                                            seconds: _controller
                                                                    .value
                                                                    .position
                                                                    .inSeconds -
                                                                4));
                                                      },
                                                      child: Image.asset(
                                                          'assets/icon/ic_prev.png'),
                                                    ),
                                                    const SizedBox(
                                                      width: 19.78,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _controller.seekTo(Duration(
                                                            seconds: _controller
                                                                    .value
                                                                    .position
                                                                    .inSeconds +
                                                                4));
                                                      },
                                                      child: Image.asset(
                                                          'assets/icon/ic_next.png'),
                                                    ),
                                                    const SizedBox(
                                                      width: 19.68,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _controller.setVolume(
                                                                _controller.value
                                                                            .volume ==
                                                                        1.0
                                                                    ? 0
                                                                    : 1.0);
                                                          });
                                                        },
                                                        child: _controller.value
                                                                    .volume ==
                                                                1.0
                                                            ? Image.asset(
                                                                'assets/icon/ic_sound.png')
                                                            : const Icon(
                                                                Icons.music_off,
                                                                color:
                                                                    Colors.red,
                                                                size: 12,
                                                              )),
                                                    const Spacer(),
                                                    Image.asset(
                                                        'assets/icon/ic_settings.png'),
                                                    const SizedBox(
                                                      width: 15.24,
                                                    ),
                                                    Image.asset(
                                                        'assets/icon/ic_fullscreen.png'),
                                                    const SizedBox(
                                                      width: 1,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: AppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            leading: GestureDetector(
                                // padding: EdgeInsets.zero,
                                onTap: () {
                                  _key.currentState.openDrawer();
                                },
                                child: Image.asset('assets/icon/ic_menu.png')),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  //navigate to profile page
                                  Navigator.pushNamed(context, Routes.profile);
                                },
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(16), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        43 / 2), // Image radius
                                    child: AppConstants
                                                .loggedUser.userData.imageURL ==
                                            null
                                        ? Image.asset(
                                            'assets/icon/ic_person.png')
                                        : Image.network(
                                            AppConstants
                                                .loggedUser.userData.imageURL,
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((index - 1) >= 0) _playPrevVideo();
                            },
                            child: Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                color: (index) == 0
                                    ? Colors.grey
                                    : AppConstants.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  size: 16),
                            ),
                          ),
                          if (AppConstants.availableVideos[index].isDownloaded)
                            GestureDetector(
                              onTap: () {
                                _delete();
                              },
                              child: Container(
                                height: 43,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: AppConstants.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.remove_circle),
                                    SizedBox(width: 5),
                                    Text(
                                      "Remove",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            )
                          else
                            downloadLoader
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      _download();
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: AppConstants.isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              'assets/icon/ic_down.png'),
                                          const SizedBox(width: 12),
                                          Text(
                                            "Download",
                                            style: TextStyle(
                                                color: AppConstants.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          GestureDetector(
                            onTap: () {
                              if ((index) <
                                  (AppConstants.availableVideos.length - 1)) {
                                _playNextVideo();
                              }
                            },
                            child: Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                color: index >=
                                        (AppConstants.availableVideos.length -
                                            1)
                                    ? Colors.grey
                                    : AppConstants.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //download status
                    if (AppConstants.availableVideos[index].isDownloaded ==
                        false)
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: StreamBuilder(
                            stream: _bloc.downloadStatus,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    snapshot.error.toString(),
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              }
                              switch (snapshot.connectionState) {
                                case ConnectionState.active:
                                  return Center(
                                    child: Text(
                                      "Downloading... ${snapshot.data}",
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  );
                                  break;
                                default:
                                  return Container();
                              }
                            }),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  _download() async {
    if (mounted) {
      setState(() {
        downloadLoader = true;
      });
    }
    final String downloadedPath = await _bloc.downloadFile(
        '${AppConstants.availableVideos[index].url}&export=download',
        "${AppConstants.availableVideos[index].title}.mp4");
    if (mounted) {
      setState(() {
        downloadLoader = false;
      });
    }
    if (downloadedPath != null) {
      setState(() {
        AppConstants.availableVideos[index].isDownloaded = true;
        AppConstants.availableVideos[index].localPathDirectory = downloadedPath;
        //update path string in local storage
      });
      await _bloc.updateVideoLibrary();
      await attachVideoTOPlayer();
    }
  }

  _playNextVideo() async {
    index += 1;
    _controller.pause();
    _controller = null;
    await attachVideoTOPlayer();
  }

  _playPrevVideo() async {
    index -= 1;
    _controller.pause();
    _controller = null;
    await attachVideoTOPlayer();
  }

  void _delete() async {
    try {
      File(AppConstants.availableVideos[index].localPathDirectory).delete();
      CustomWidgets.showSnackbar("Deleted from local storage", context);
      setState(() {
        AppConstants.availableVideos[index].isDownloaded = false;
        AppConstants.availableVideos[index].localPathDirectory = null;
      });
      await _bloc.updateVideoLibrary();
    } catch (e) {
      CustomWidgets.showSnackbar("Delete task failed", context);
    }
  }
}
