import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/router.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavbarProvider()),
      ],
      child: MaterialApp(
        title: 'Mobile Stock Opname',
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: StringRouterUtil.splashScreenRoute,
      ),
    );
  }
}
