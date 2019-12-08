import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_button.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'package:flutter_inus_pray/screen/take_picture.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name;
  bool _isTakePicture = false;
  String _takeImagePath;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final double imageSize = 230.0;

  @override
  initState() {
    super.initState();
    Fluttertoast.showToast(
      msg: "뒤로가기시 자동으로 수정 내용이 저장됩니다.",
    );
  }

  Future<void> _setUpCamera() async {
    final cameras = await availableCameras();
    // final camera = cameras.first;
    final camera = cameras[1];
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    return _initializeControllerFuture;
  }

  _saveMyProfile() {}

  _voidPictureChange(context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('카메라 찍기'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _isTakePicture = true;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_media),
                  title: Text('갤러리에서 가져오기'),
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }

  Future<bool> _backPressEvent() {
    _saveMyProfile();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressEvent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('프로필 수정'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleButton(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: _isTakePicture
                          ? FutureBuilder(
                              future: _setUpCamera(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ClipOval(
                                    child: _takeImagePath == null
                                        ? Container(
                                          height: imageSize,
                                          width: imageSize,
                                            child: CameraPreview(
                                              _controller,
                                            ),
                                          )
                                        : Image.file(
                                            File(_takeImagePath),
                                            width: imageSize,
                                            height: imageSize,
                                            fit: BoxFit.cover,
                                          ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          : CircleImage(
                              size: imageSize,
                              imagePath: UserMock.profileImagePath,
                            ),
                    ),
                    _isTakePicture
                        ? Container()
                        : Center(
                            child: Container(
                              width: imageSize,
                              height: imageSize,
                              child: Center(
                                child: Icon(
                                  Icons.touch_app,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                  ],
                ),
                onPressed: () => _voidPictureChange(context),
              ),
              Container(
                padding: EdgeInsets.only(top: 15.0),
                height: 100.0,
                width: 90.0,
                child: UnderlineTextField(
                  textValue: UserMock.name,
                  onChanged: (name) => _name,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  hintText: '이름 입력',
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _isTakePicture
            ? FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    _takeImagePath = join(
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );
                    await _controller.takePicture(_takeImagePath);
                    setState(() {});
                  } catch (e) {}
                },
              )
            : Container(),
      ),
    );
  }
}
