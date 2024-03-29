import 'package:flutter/cupertino.dart';

import 'strings/strings.dart';

class R {
  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'en_Us':
        strings = EnUs();
        break;
      default:
        strings = PtBr();
        break;
    }
  }
}
