import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/errors/repository_error.dart';
import 'package:offertelavoroflutter/models/filter_job_offer.dart';
import 'package:offertelavoroflutter/models/job_offer.dart';
import 'package:offertelavoroflutter/repositories/notion/databases_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'job_offer_event.dart';
part 'job_offer_state.dart';

const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class JobOfferBloc extends Bloc<JobOfferEvent, JobOfferState> {
  final DatabasesRepository databasesRepository;

  JobOfferBloc({required this.databasesRepository}) : super(const FetchingJobOfferState()) {
    on<FetchJobOfferEvent>(
      _onFetch,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FetchWithParamsJobOfferEvent>(
      _onFetchWithParams,
    );
  }

  FutureOr<void> _onFetch(FetchJobOfferEvent event, Emitter<JobOfferState> emit) async {
    try {
      if (state is FetchingJobOfferState) {
        final currentState = state as FetchingJobOfferState;

        final response = await databasesRepository.recruitments(
          params: currentState.params?.toJson(true) ?? {}
        );
        return emit(response.results.isEmpty 
          ? NoJobOfferState() 
          : FetchedJobOfferState(
              jobOffers: response.results,
              nextCursor: response.nextCursor,
              hasMore: response.hasMore,
              params: currentState.params ?? const FilterJobOffer(),
            )
        );
      }
      if (state is FetchedJobOfferState) {
        final currentState = state as FetchedJobOfferState;
        if (!currentState.hasMore) return;

        final FilterJobOffer? params = currentState.params
          ?.copyWith(startCursor: currentState.nextCursor);
  
        final response = await databasesRepository.recruitments(params: params?.toJson(true) ?? {});
        return emit(FetchedJobOfferState(
            jobOffers: currentState.jobOffers + response.results,
            nextCursor: response.nextCursor,
            hasMore: response.hasMore,
            params: currentState.params,
          )
        );
      }
    } on RepositoryError catch (e) {
      emit(ErrorJobOfferState(e.errorMessage));
    } catch (e) {
      emit(const ErrorJobOfferState());
    }
  }

  void fetchJobOffer(String databaseType) => add(const FetchJobOfferEvent());


  FutureOr<void> _onFetchWithParams(FetchWithParamsJobOfferEvent event, Emitter<JobOfferState> emit) {
    if (state is FetchedJobOfferState) {
      final currentState = state as FetchedJobOfferState;
      emit(FetchingJobOfferState(
        params: event.params ?? currentState.params,
      ));
      fetchJobOffer('recruitments');
    }
  }

}