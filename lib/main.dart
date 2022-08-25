import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:infomercados/services/auth_service.dart';
import 'package:infomercados/services/indices_service.dart';
import 'package:infomercados/services/push_service.dart';
import 'package:provider/provider.dart';

import 'package:infomercados/screens/screens.dart';
import 'package:infomercados/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PushService()),
        // ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        // ChangeNotifierProvider(create: ( _ ) => ProductsService() ),
        ChangeNotifierProvider(create: (_) => IndicesService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        // 'checking': ( _ ) => CheckAuthScreen(),

        'home': (_) => Home3Screen(),
        // 'product' : ( _ ) => ProductScreen(),

        // 'login'   : ( _ ) => LoginScreen(),
        // 'register': ( _ ) => RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.dark().copyWith(

          // scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              elevation: 0,
              color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.amberAccent, elevation: 0)),
    );
  }
}
