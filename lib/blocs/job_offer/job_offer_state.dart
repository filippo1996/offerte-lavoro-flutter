part of 'job_offer_bloc.dart';

abstract class JobOfferState extends Equatable {
  const JobOfferState();

  @override
  List<Object?> get props => [];
}

class FetchingJobOfferState extends JobOfferState {
  final FilterJobOffer? params;

  const FetchingJobOfferState({
    this.params,
  });

  FetchingJobOfferState copyWith({
    final FilterJobOffer? params,
  }) {
    return FetchingJobOfferState(
      params: params ?? this.params,
    );
  }

  @override
  List<Object?> get props => [params];
}

class FetchedJobOfferState extends JobOfferState {
  final List<JobOffer> jobOffers;
  final bool hasMore;
  final String? nextCursor;
  final FilterJobOffer? params;

  const FetchedJobOfferState({
    required this.jobOffers,
    required this.hasMore,
    required this.nextCursor,
    this.params,
  });

  @override
  List<Object?> get props => [
    jobOffers,
    hasMore,
    nextCursor,
    params,
  ];
}

class NoJobOfferState extends JobOfferState {}

class ErrorJobOfferState extends JobOfferState {
  final String? errorMessage;

  const ErrorJobOfferState([this.errorMessage]);

  @override
  List<Object?> get props => [errorMessage];
}
