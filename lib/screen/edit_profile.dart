import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_button.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name;
  File _imageFile;
  final double imageSize = 230.0;

  @override
  initState() {
    super.initState();
    Fluttertoast.showToast(
      msg: "뒤로가기시 자동으로 수정 내용이 저장됩니다.",
    );
  }

  _saveMyProfile() {}

  _voidPictureChange(context, User user) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('카메라 찍기'),
                  onTap: () async {
                    var picture = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picture != null) {
                      var cropPicture = await _imageCrop(picture.path);
                      _uploadStorage(cropPicture, user);
                    }

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.perm_media),
                  title: Text('갤러리에서 가져오기'),
                  onTap: () async {
                    var picture = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picture != null) {
                      var cropPicture = await _imageCrop(picture.path);
                      _uploadStorage(cropPicture, user);
                    }
                    Navigator.pop(context);
                  },
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

  Future<File> _imageCrop(String picturePath) => ImageCropper.cropImage(
        sourcePath: picturePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );

  _uploadStorage(File picture, User user) async {
    var path = 'profile_images/${user.phoneNumber}';
    final StorageReference storageReference =
        FirebaseStorage().ref().child(path);
    StorageUploadTask uploadTask = storageReference.putFile(picture);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      user.updateUserProfileImage(fileURL);
    });
    Fluttertoast.showToast(
      msg: "이미지가 변경되었습니다.",
    );
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
          child: Consumer<User>(
            builder: (BuildContext context, User user, Widget widget) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleButton(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: _imageFile == null
                              ? CircleImage(
                                  size: imageSize,
                                  imagePath: user.profileImage,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    _imageFile,
                                    width: imageSize,
                                    height: imageSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        _imageFile == null
                            ? Center(
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
                              )
                            : Container(),
                      ],
                    ),
                    onPressed: () => _voidPictureChange(context, user),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    height: 100.0,
                    width: 90.0,
                    child: UnderlineTextField(
                      textValue: user.name,
                      onChanged: (name) => _name,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      hintText: '이름 입력',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
