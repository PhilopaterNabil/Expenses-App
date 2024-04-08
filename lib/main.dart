import 'package:expenses/views/widgets/expenses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ColorScheme myColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 59, 96, 179),
  );
  static final ColorScheme myDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 9, 91, 133),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData().copyWith(
          colorScheme: myColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myColorScheme.onPrimaryContainer,
            foregroundColor: myColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: myColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: myColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: myColorScheme.onSecondaryContainer,
                  fontSize: 17,
                ),
              )),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: myDarkColorScheme,
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: myDarkColorScheme.onPrimaryContainer,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myDarkColorScheme.onPrimaryContainer,
          foregroundColor: myDarkColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: myDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myDarkColorScheme.onPrimaryContainer,
            foregroundColor: myDarkColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: myDarkColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      home: const ExpansesView(),
    );
  }
}
