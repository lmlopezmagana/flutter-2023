import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_app/route/route_names.dart';
import 'package:photo_app/ui/edit_page.dart';
import 'package:photo_app/ui/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeEdit:
      //default: // else
        return MaterialPageRoute(
            builder: (_) => EditPhotoPage(
                  image: settings.arguments as File,
                ));
        //break;
      //case routeHome:
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
        //break;  
    }
  }
}
