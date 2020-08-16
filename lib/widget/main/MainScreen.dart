import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todorenest/Routes.dart';
import 'package:todorenest/localization.dart';
import 'package:todorenest/widget/main/tasks/CurrentTasksListScreen.dart';

import 'completed/CompletedTasksListScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _onAddTodoClick(context),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(98),
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: InkWell(
                      child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.search),
                              hintText:
                                  ReNestLocalizations.of(context).searchHint)),
                      onTap: () => _onSearchClick(context),
                    ),
                  ),
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: ReNestLocalizations.of(context).tasks,
                      ),
                      Tab(text: ReNestLocalizations.of(context).completed)
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                ]),
              ),
              title: Text(ReNestLocalizations.of(context).appName),
            ),
            body: Column(children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: TabBarView(
                      children: <Widget>[
                        CurrentTasksListScreen(),
                        CompletedTasksListScreen()
                      ],
                    ))
                  ],
                ),
              )
            ])),
      );

  void _onAddTodoClick(BuildContext context) =>
      Navigator.pushNamed(context, Routes.templates);

  void _onSearchClick(BuildContext context) =>
      Navigator.pushNamed(context, Routes.search);
}
