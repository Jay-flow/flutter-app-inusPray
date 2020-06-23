import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/components/underline_text_field.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/components/circle_icon_button.dart';
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
  User _user;
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
  }

  _pictureChange(context) {
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
                      _uploadStorage(cropPicture);
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
                      _uploadStorage(cropPicture);
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
    if (_name != null && _user != null) {
      _name = _name.trim();
      if (_validate()) {
        _user.updateUserName(_name);
      } else {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  bool _validate() {
    if (_name.length > 10) {
      Fluttertoast.showToast(msg: "이름이 너무깁니다. (10자 이하로 입력)");
      return false;
    }
    if (_name == '') {
      Fluttertoast.showToast(msg: "이름은 공백으로 둘 수 없습니다.");
      return false;
    }
    return true;
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

  _uploadStorage(File picture) async {
    setState(() {
      _isLoading = true;
    });
    var path = 'profile_images/${_user.phoneNumber}';
    final StorageReference storageReference =
        FirebaseStorage().ref().child(path);
    StorageUploadTask uploadTask = storageReference.putFile(picture);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      _user.updateUserProfileImage(fileURL);
    });
    setState(() {
      _isLoading = false;
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
          child: LoadingContainer(
            isLoading: _isLoading,
            child: Consumer<User>(
              builder: (BuildContext context, User user, Widget widget) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 35),
                          child: CircleImage(
                            size: 200,
                            imagePath: user.profileImage,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 15.0),
                    //   height: 100.0,
                    //   width: 90.0,
                    //   child: Row(
                    //     children: <Widget>[
                    //       UnderlineTextField(
                    //         textValue: user.name,
                    //         onChanged: (name) {
                    //           _user = user;
                    //           _name = name;
                    //         },
                    //         textAlign: TextAlign.center,
                    //         keyboardType: TextInputType.text,
                    //         hintText: '이름 입력',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
