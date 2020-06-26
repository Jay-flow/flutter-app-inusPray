import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/screen/edit_name.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/circle_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  _changePicture() {
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
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 15.0,
                            bottom: 5.0,
                          ),
                          child: CircleImage(
                            imagePath: user.profileImage,
                          ),
                        ),
                        Text(
                          user.name + ', ' + user.church,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        height: 160,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '왕이여 우리가 섬기는 하나님이 계신다면 우리를 맹렬히 타는 풀무불 가운데에서 능히 건져내시겠고 왕의 손에서도 건져내시리이다. ',
                                    ),
                                    TextSpan(
                                        text: "'그렇게 하지 아니하실지라도'",
                                        style: TextStyle(
                                          color: Asset.Colors.yellow,
                                        )),
                                    TextSpan(
                                      text:
                                          ' 왕이여 우리가 왕의 신들을 섬기지도 아니하고 왕이 세우신 금 신상에게 절하지도 아니할 줄을 아옵소서',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '다니엘 3:17-18',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  CircleIconButton(
                                    child: Icon(
                                      Icons.border_color,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      EditName.id,
                                    ),
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('이름 변경')
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50.0),
                              child: Column(
                                children: <Widget>[
                                  CircleIconButton(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.church,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.8,
                                        ),
                                      ],
                                    ),
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                    padding: EdgeInsets.all(15),
                                    onPressed: () {},
//                              onPressed: () => _pictureChange(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('교회명 변경')
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: 50.0, right: 15.0),
                              child: Column(
                                children: <Widget>[
                                  CircleIconButton(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    fillColor:
                                        Theme.of(context).primaryColorLight,
                                    padding: EdgeInsets.all(15),
                                    onPressed: () => _changePicture(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('사진 변경')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
