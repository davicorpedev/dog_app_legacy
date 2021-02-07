import 'package:dog_app/core/pages/splash_screen.dart';
import 'package:dog_app/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Doggo",
      theme: ThemeData(
        fontFamily: 'Montserrat',
        brightness: Brightness.light,
        primaryColor: Color(0xFFf0e4b1),
        primaryColorDark: Color(0xFFceaf67),
        primaryColorLight: Color(0xFFf9eed9),
        accentColor: Color(0xFF5a3a1a),
        disabledColor: Color(0xFFBCBCBC),
        buttonColor: Color(0xFF5a3a1a),
        scaffoldBackgroundColor: Color(0xFFf9eed9),
        dialogBackgroundColor: Color(0xFFf9eed9),
        canvasColor: Color(0xFFf9eed9),
        errorColor: Colors.red,
        unselectedWidgetColor: Color(0xFFf9eed9),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF5a3a1a),
          foregroundColor: Color(0xFFf9eed9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color(0xFFf9eed9),
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: "Montserrat",
              color: Color(0xFF5a3a1a),
            ),
          ),
          iconTheme: IconThemeData(color: Color(0xFF5a3a1a)),
          actionsIconTheme: IconThemeData(color: Color(0xFF5a3a1a)),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF5a3a1a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF5a3a1a), size: 20),
        //accentIconTheme: IconThemeData(color: Color(0xFFFFEFFA), size: 16),
        //chipTheme: ChipThemeData(),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Color(0xFF5a3a1a),
          ),
          headline6:TextStyle(
            color: Color(0xFF5a3a1a),
          ) ,
          subtitle1: TextStyle(
            color: Color(0xFF5a3a1a),
          ),
          subtitle2: TextStyle(
            color: Color(0xFF5a3a1a),
          ),
          bodyText1: TextStyle(
            color: Color(0xFF5a3a1a),
          ),
          bodyText2: TextStyle(
            color: Color(0xFF5a3a1a),
          ),
        )
      ),
      home: SplashScreen(),
    );
  }
}
