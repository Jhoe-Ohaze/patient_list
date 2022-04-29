import 'package:flutter/material.dart';
import 'package:patient_list/backend/database.dart';
import 'package:patient_list/pages/home_page.dart';

import '../assets/image_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void loadData() async {
    await Database.loadData();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(ImageAssets.logo),
              ),
            ),
            const SizedBox(child: CircularProgressIndicator()),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
