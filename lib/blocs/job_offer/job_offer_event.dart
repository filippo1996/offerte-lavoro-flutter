part of 'job_offer_bloc.dart';

abstract class JobOfferEvent extends Equatable {
  const JobOfferEvent();

  @override
  List<Object?> get props => [];
}

class FetchJobOfferEvent extends JobOfferEvent {
  final String? databaseType;

  const FetchJobOfferEvent([this.databaseType]);

  @override
  List<Object?> get props => [databaseType];
}


class FetchWithParamsJobOfferEvent extends JobOfferEvent {
  final FilterJobOffer? params;
  
  const FetchWithParamsJobOfferEvent({
    this.params,
  });

  @override
  List<Object?> get props => [params];
}