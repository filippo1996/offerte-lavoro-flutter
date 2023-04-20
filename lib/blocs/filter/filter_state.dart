part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FetchingFilterState extends FilterState {}

class FetchedFilterState extends FilterState {
  final List<String> sortingProperty;
  final List<String> sortDirection;

  const FetchedFilterState({
    required this.sortingProperty,
    required this.sortDirection,
  });

  @override
  List<Object> get props => [sortingProperty];
}