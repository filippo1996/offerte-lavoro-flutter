import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/blocs/filter/filter_bloc.dart';
import 'package:offertelavoroflutter/blocs/job_offer/job_offer_bloc.dart';
import 'package:offertelavoroflutter/repositories/notion/databases_repository.dart';
import 'package:offertelavoroflutter/ui/components/app_bar.dart';
import 'package:offertelavoroflutter/ui/components/footer.dart';
import 'package:offertelavoroflutter/ui/pages/freelance/home_freelance_page.dart';
import 'package:offertelavoroflutter/ui/pages/recruitment/home_recruitment_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const route = '/'; 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const AppBarComponent(),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MultiBlocProvider(
              providers: [
                BlocProvider<JobOfferBloc>(
                  create: (context) => 
                  JobOfferBloc(databasesRepository: context.read<DatabasesRepository>())
                  ..fetchJobOffer('recruitment'),
                ),
                BlocProvider<FilterBloc>(
                  create: (context) => 
                  FilterBloc()..fetchFilter(),
                ),
              ],
              child: const HomeRecruitmentPage(),
            ),
            BlocProvider(
              create: (context) => 
                JobOfferBloc(databasesRepository: context.read<DatabasesRepository>())
                ..fetchJobOffer('freelance'),
              child: const HomeFreelancePage(),
            ),
          ],
        ),
        persistentFooterButtons: const [
          Center(child: FooterComponent()),
        ],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up),
              label: "Like",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_down),
              label: "Dislike",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: "Comment",
            )
          ],
        ),
      ),
    );
  }
}