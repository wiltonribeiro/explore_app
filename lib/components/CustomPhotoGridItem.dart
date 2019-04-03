import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:explore_flutter/views/PhotoDetails.dart';

class CustomPhotoGridItem extends StatelessWidget {

  final Photo photo;
  final double width;
  final double height;

  CustomPhotoGridItem({Key key, this.photo, this.width, this.height}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(child:
        new Hero(tag: "photo${this.photo.id}", child:
          new ClipRRect(borderRadius: BorderRadius.circular(20), child:
            new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              height: this.height,
              width: this.width,
              image: photo.smallURL,
            )
          )
        ),
        onTap: (){
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return new PhotoDetails(photo: this.photo);
              }
          ));
        },
    );
  }

}