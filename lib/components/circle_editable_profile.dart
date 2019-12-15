import 'package:flutter/material.dart';
import 'circle_button.dart';
import 'circle_image.dart';
import 'package:flutter_inus_pray/screen/edit_profile.dart';

class CircleEditableProfile extends StatelessWidget {
  CircleEditableProfile({
    @required this.name,
    @required this.profileImagePath,
  });

  final String name;
  final String profileImagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            CircleImage(
              imagePath: profileImagePath,
            ),
            Positioned(
              bottom: 0,
              right: -25,
              child: CircleButton(
                child: Icon(
                  Icons.create,
                ),
                onPressed: () => Navigator.pushNamed(context, EditProfile.id),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
