import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  static String routeName = "/notFound";

  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("not found page")));
  }
}
