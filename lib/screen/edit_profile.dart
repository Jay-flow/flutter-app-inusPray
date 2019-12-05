import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_button.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:camera/camera.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name;
  List<CameraDescription> cameras;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  _saveMyProfile() {}

  Future<void> _takeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    
  }

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
                  onTap: () => _takeCamera,
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
                      child: CircleImage(
                        size: 230.0,
                        imagePath: UserMock.profileImagePath,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 230.0,
                        height: 230.0,
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
                width: 150.0,
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
      ),
    );
  }
}
