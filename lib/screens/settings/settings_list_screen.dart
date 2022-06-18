import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_video_stream/core/app_constants.dart';

import '../../main.dart';

class SettingsListScreen extends StatefulWidget {
  const SettingsListScreen({Key key}) : super(key: key);

  @override
  State<SettingsListScreen> createState() => _SettingsListScreenState();
}

class _SettingsListScreenState extends State<SettingsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dark Theme"),
                    Switch(
                        value: AppConstants.isDarkMode,
                        onChanged: (val) {
                          final MyAppState state =
                              context.findAncestorStateOfType<MyAppState>();
                          state.changeTheme();
                          setState(() {
                            //update value
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
