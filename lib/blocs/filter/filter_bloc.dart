import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/models/filter_job_offer.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState>{
  FilterBloc() : super(FetchingFilterState()) {
    on<FetchFilterEvent>(
      _onFetch
    );
  }

  FutureOr<void> _onFetch(FetchFilterEvent event, Emitter<FilterState> emit) async {
    emit(const FetchedFilterState(
      // Consideriamo che queste property siano state ottenute tramite chiamata
      sortingProperty: FilterJobOffer.properties,
      sortDirection: FilterJobOffer.sortDirection,
    ));
  }

  void fetchFilter() => add(FetchFilterEvent());
}