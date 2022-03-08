import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fordev/main/factories/pages/login/login_page_factory.dart';
import 'package:get/get.dart';

import '../ui/components/components.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(name: '/surveys', page: () => Scaffold(body: Center(child: Text('Página Enquetes!')))),
      ],
    );
  }
}
