import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static page() {
    const route = 'splash';
    return const MaterialPage(
      child: SplashScreen(),
      key: ValueKey(route),
      name: route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Checking user data...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
