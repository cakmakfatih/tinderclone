import 'package:flutter/material.dart';
import '../models/profile.dart';
import 'photo_browser.dart';

class ProfileCard extends StatefulWidget {

  final Profile profile;

  ProfileCard({
    Key key,
    this.profile,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();

}

class _ProfileCardState extends State<ProfileCard> {

  Widget _buildBackground() {
    return PhotoBrowser (
      photoUrls: widget.profile.photos,
      visiblePhotoIndex: 0,
    );
  }

  Widget _buildProfileSynapsis() {
    return Positioned (
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container (
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration (
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ]
          )
        ),
        child: Row (
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded (
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget> [
                  RichText (
                    text: TextSpan (
                      children: <TextSpan> [
                        TextSpan (
                          text: widget.profile.name,
                          style: TextStyle (
                            fontWeight: FontWeight.w700,
                            fontSize: 29.0
                          )
                        ),
                        TextSpan (
                          text: " ${widget.profile.age ?? widget.profile.age}",
                          style: TextStyle (
                            fontSize: 22.0
                          )
                        ),
                      ]
                    ),
                  ),
                  widget.profile.education != null ? Row (
                    children: <Widget> [
                      Icon(Icons.school, color: Colors.white),
                      Container(margin: EdgeInsets.symmetric(horizontal: 5.0)),
                      Text (
                        widget.profile.education,
                        style: TextStyle (
                          color: Colors.white
                        ),
                      ),
                    ],
                  ) : Container(),
                  Row (
                    children: <Widget> [
                      Icon(Icons.location_on, color: Colors.white),
                      Container(margin: EdgeInsets.symmetric(horizontal: 5.0)),
                      Text (
                        "${widget.profile.distance} km uzakta",
                        style: TextStyle (
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  widget.profile.bio != null ? Text (
                    widget.profile.bio,
                    style: TextStyle (
                      color: Colors.white
                    ),
                  ) : Container()
                ],
              ),
            ),
            Icon (
              Icons.info,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: BoxDecoration (
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow (
            color: Color(0x11000000),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: ClipRRect (
        borderRadius: BorderRadius.circular(10.0),
        child: Material (
          child: Stack (
            fit: StackFit.expand,
            children: <Widget> [
              _buildBackground(),
              _buildProfileSynapsis()
            ],
          ),
        ),
      ),
    );
  }

}