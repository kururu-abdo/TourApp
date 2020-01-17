import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tourapp/Ui/app.dart';
import 'package:tourapp/main.dart';

class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(model: AppModel(), child: App());
  }
}

class AppModel extends Model {
  Locale _appLocale = Locale('ar');
  Locale get appLocal => _appLocale ?? Locale("ar");

  void changeDirection() {
    if (_appLocale == Locale("ar")) {
      _appLocale = Locale("en");
    } else {
      _appLocale = Locale("ar");
    }
    notifyListeners();
  }
}