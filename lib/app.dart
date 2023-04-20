import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/repositories/notion/databases_repository.dart';
import 'package:offertelavoroflutter/repositories/notion/mappers/freelance_page_mapper.dart';
import 'package:offertelavoroflutter/repositories/notion/mappers/recruitment_page_mapper.dart';
import 'package:offertelavoroflutter/services/network/notion/databases_service.dart';
import 'package:provider/provider.dart';

import 'ui/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruitmentPageMapper>(
          create: (_) => RecruitmentPageMapper(),
        ),
        Provider<FreelancePageMapper>(
          create: (_) => FreelancePageMapper(),
        )
      ],
      child: MultiProvider(
        providers: [
          Provider<DatabasesService>(
            create: (_) => const DatabasesService(),
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DatabasesRepository>(
              create: (context) => DatabasesRepository(
                databasesService: context.read<DatabasesService>(), 
                recruitmentPageMapper: context.read<RecruitmentPageMapper>(),
                freelancePageMapper: context.read<FreelancePageMapper>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Offerte di lavoro flutter',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Montserrat',
              //primaryColorDark: ThemeColors.primaryDark,
            ),
            home: const HomePage()
          ),
        ),
      ),
    );
  }
}