import 'package:flutter/material.dart';
import 'package:diplome_dima/data/utils/styles.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final String title;

  const AppPage({
    Key? key,
    required this.child,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        automaticallyImplyLeading: false,
        //leading: const AutoLeadingButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 32, left: 24, right: 24
        ),
        child: SizedBox(
          child: child
        )
      ),
    );
  }
}
