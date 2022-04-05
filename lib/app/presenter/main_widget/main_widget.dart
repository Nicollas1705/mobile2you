import 'package:flutter/material.dart';
import 'package:mobile2you/app/presenter/pages/movie_page.dart';
import 'package:mobile2you/app/presenter/themes/dark_theme.dart';
import 'package:mobile2you/shared/constants/constants.dart';
import 'package:mobile2you/shared/utils/app_scroll_behavior.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DarkTheme.theme,
      themeMode: ThemeMode.dark,
      home: MoviePage(movieId: MOVIE_ID),
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
    );
  }
}
