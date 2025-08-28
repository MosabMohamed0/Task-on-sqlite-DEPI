import 'dart:convert';

import 'package:depi/sessions_tasks/expence_tracker/expense_tracker.dart';
import 'package:depi/sessions_tasks/expence_tracker/sqlflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:depi/sessions_tasks/ApplyingInteractivity.dart';
import 'package:depi/sessions_tasks/Drag_and_Drop_App.dart';
import 'package:depi/sessions_tasks/GridVeiw.dart';
import 'package:depi/sessions_tasks/TaskTracker.dart';
import 'package:depi/sessions_tasks/bottom_navigation_bar/Controller.dart';
import 'package:depi/sessions_tasks/navigator.dart' show MyNavigator;
import 'package:depi/sessions_tasks/provider_task/catalog.dart';
import 'package:depi/task_0/HomePage.dart';
import 'package:depi/task_1/Home.dart';
import 'package:depi/task_1/advanced_profile_card.dart';
import 'package:depi/task_1/burger.dart';
import 'package:depi/task_1/landscape.dart';
import 'package:depi/task_1/login.dart';
import 'package:depi/task_1/music_player.dart';
import 'package:depi/task_2/grid_view.dart';
import 'package:depi/task_3/Grid.dart';
import 'package:depi/task_3/my_grid_enhanced.dart';
import 'package:depi/task_4/catalog.dart';
import 'package:depi/task_4/my_provider.dart';
import 'package:depi/task_5/catalog.dart';
import 'package:depi/task_5/my_cubit.dart';

// provider

// void main() {
//   runApp(ChangeNotifierProvider(create: (_) => CardModel(), child: MyApp()));
// }



// cubit

// void main() {
//   runApp(BlocProvider(create: (context) => CatalogCubit(), child: MyApp()));
// }



//sqlite
void main() async{
  //تتحط لو هتضيف اي حاجه قبل runapp
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDatabase.initDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}
