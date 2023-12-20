import 'package:flutter/material.dart';

Route<dynamic> createRoute(Widget Function(BuildContext context) builder) =>
    PageRouteBuilder(pageBuilder: (context, _, __) => builder(context));
