import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  //todo localization
  runApp(MyApp());
}

