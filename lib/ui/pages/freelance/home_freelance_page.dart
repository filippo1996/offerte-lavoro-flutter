import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/blocs/job_offer/job_offer_bloc.dart';
import 'package:offertelavoroflutter/models/job_offer.dart';

class HomeFreelancePage extends StatelessWidget {
  const HomeFreelancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobOfferBloc, JobOfferState>(
      builder:(context, state) {
        if (state is FetchedJobOfferState) {
          //print(state.pages);
          //return Text('recuperato le pagine dal db ${state.pages[0].image}', style: const TextStyle(fontSize: 20),);
          return Column(children: [
            Text('${state.jobOffers[0].image} ${state.jobOffers[0].name}', style: const TextStyle(fontSize: 20),),
            Expanded(
              child: ListView.builder(
                itemCount: state.jobOffers.length,
                itemBuilder: (context, index) => Text((state.jobOffers[index] as Recruitment).toString()),
              ),
            ),
          ],);
        } else if (state is ErrorJobOfferState) {
          return Text('Errore -> ${state.errorMessage ?? 'Generic Error'}');
        } else if (state is NoJobOfferState) {
          return const Text('Nessuna pagina disponibile');
        }
        return const Text('caricamento in corso');
      },
    );
  }
}