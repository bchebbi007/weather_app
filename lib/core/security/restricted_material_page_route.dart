import 'package:flutter/material.dart';


class RestrictedMaterialPageRoute<T> extends MaterialPageRoute<T> {

  RestrictedMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings) ;


}