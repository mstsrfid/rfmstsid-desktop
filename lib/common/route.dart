import 'package:flutter/material.dart';

Route<dynamic> createRoute(Widget widget) =>
    PageRouteBuilder(pageBuilder: (_, __, ___) => widget);
