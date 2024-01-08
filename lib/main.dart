import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meditation/core/meditation_urls.dart';
import 'package:meditation/features/splash/splash_screen.dart';
import 'package:meditation/logic/get_premium/prem_hive_model/prem_hive_model.dart';
import 'package:meditation/logic/start_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Apphud.start(apiKey: MeditationUrls.apphudApiKey);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(NewPosterModelAdapter());
  await startLogic();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meditation',
        home: child,
        theme: ThemeData.light().copyWith(
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      ),
      child: const SplashScreen(),
    );
  }
}
