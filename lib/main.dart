import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todorenest/MainComponent.dart';
import 'package:todorenest/Routes.dart';
import 'package:todorenest/domain/DomainModule.dart';
import 'package:todorenest/localization.dart';
import 'package:todorenest/persistence/database/DatabaseModule.dart';
import 'package:todorenest/widget/main/MainScreen.dart';
import 'package:todorenest/widget/main/completed/bloc/CompletedTasksListBloc.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListBloc.dart';
import 'package:todorenest/widget/main/tasks/bloc/CurrentTasksListEvents.dart';
import 'package:todorenest/widget/new/AddNewTaskScreen.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskBloc.dart';
import 'package:todorenest/widget/new/bloc/AddNewTaskEvent.dart';
import 'package:todorenest/widget/search/SearchScreen.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenBloc.dart';
import 'package:todorenest/widget/search/bloc/SearchScreenEvent.dart';

void main() {
  runApp(MyApp());
}

final applicationComponent = MainComponent(DomainModule(), DatabaseModule());

final routes = {
  Routes.home: (context) => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) =>
              CurrentTasksListBloc(applicationComponent.provideTasksRepo())
                ..add(LoadCurrentTasksEvent()),
        ),
        BlocProvider(
            create: (context) =>
                CompletedTasksListBloc(applicationComponent.provideTasksRepo()))
      ], child: MainScreen()),
  Routes.templates: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AddNewTaskBloc(applicationComponent.provideTasksRepo())
                    ..add(LoadTaskTemplatesEvent()))
        ],
        child: AddNewTaskScreen(),
      ),
  Routes.search: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchScreenBloc(applicationComponent.provideTasksRepo())
                  ..add(SearchTasksEvent("")),
          ),
          BlocProvider(
            create: (context) =>
            CurrentTasksListBloc(applicationComponent.provideTasksRepo()),
          ),
        ],
        child: SearchScreen(),
      )
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ReNest Demo",
        initialRoute: Routes.home,
        routes: routes,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[200],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          ReNestLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
        ]);
  }
}
