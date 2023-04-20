import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offertelavoroflutter/blocs/filter/filter_bloc.dart';
import 'package:offertelavoroflutter/blocs/job_offer/job_offer_bloc.dart';
import 'package:offertelavoroflutter/models/filter_job_offer.dart';
import 'package:offertelavoroflutter/models/job_offer.dart';
import 'package:offertelavoroflutter/ui/components/bottom_loader.dart';
import 'package:offertelavoroflutter/ui/components/drop_down_list.dart';
import 'package:offertelavoroflutter/ui/components/job_offer_card.dart';
import 'package:offertelavoroflutter/utils/extensions/string_extension.dart';

class HomeRecruitmentPage extends StatefulWidget {
  const HomeRecruitmentPage({super.key});

  @override
  State<HomeRecruitmentPage> createState() => _HomeRecruitmentPageState();
}

class _HomeRecruitmentPageState extends State<HomeRecruitmentPage> {
  //static const dbName = 'recruitment';
  final _scrollController = ScrollController();
  final FilterJobOffer initFilter = const FilterJobOffer();
  Direction sortDirection = Direction.ascending; // default value
  final List<Sort> sorts = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // TODO: Implementare altre parti grafiche UI
        sectionHeader(),
        sectionFilter(),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: sectionJobOffersBuilder(),
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<JobOfferBloc>().add(const FetchJobOfferEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  SliverToBoxAdapter sectionHeader() => SliverToBoxAdapter(
    child: Container(
      width: double.infinity,
      height: 200,
      color: Colors.black,
    ),
  );

  /// Methods that handle filters
  void _handleEventSortBy(dynamic actualProperty) {
    final Sort newSort = Sort(
      property: actualProperty,
      direction: sortDirection,
    );
    if (!sorts.contains(newSort)) {
      sorts.add(newSort);
    } else {
      int idx = sorts.indexOf(newSort);
      sorts[idx] = newSort;
    }
    setState(() {});
    context.read<JobOfferBloc>().add(FetchWithParamsJobOfferEvent(
        params: initFilter.copyWith(sorts: sorts),
      )
    );
  }

  void _handleEventSortDirection(dynamic actualDirection) {
    sortDirection = Direction.values.byName(actualDirection);
    setState(() {
      sortDirection;
    });
  }

  void _onRemoveAllSorts() {
    setState(() {
      sorts.clear();
      context.read<JobOfferBloc>().add(FetchWithParamsJobOfferEvent(
          params: initFilter.copyWith(sorts: sorts),
        )
      );
    });
  }

  BlocBuilder sectionFilter() => BlocBuilder<FilterBloc, FilterState>(
    builder: (context, state) {
      if (state is FetchedFilterState) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              /*
              ElevatedButton(
                onPressed: () => context.read<JobOfferBloc>().add(const FetchWithParamsJobOfferEvent(
                  filter: {
                    "property": "Team",
                    "select": {
                      "equals": "Ibrido"
                    }
                  }
                )),
                child: const Text('Filter'),
              ),
              */
              Row(
                children: [
                  // Sort by property
                  DropDownList(
                    onEvent: _handleEventSortBy,
                    attributeName: 'Ordina da',
                    icon: const Icon(Icons.list),
                    enableMultipleSelection: false,
                    listOfAttribute: state.sortingProperty.map(
                      (name) => SelectedListItem(
                        name: name,
                        value: name,
                        isSelected: false,
                      ),
                    ).toList(growable: false),
                  ),
                  // Sort type
                  DropDownList(
                    onEvent: _handleEventSortDirection,
                    attributeName: 'Sort',
                    icon: Icon(
                      sortDirection == Direction.ascending
                        ? Icons.north_rounded
                        : Icons.south_rounded
                    ),
                    listOfAttribute: state.sortDirection.map(
                      (name) => SelectedListItem(
                        name: name.capitalize(),
                        value: name,
                        isSelected: false,
                      ),
                    ).toList(growable: false),
                  ),
                  // Delete all sort
                  if (sorts.isNotEmpty)
                    TextButton.icon(
                      onPressed: _onRemoveAllSorts,
                      icon: const Icon(Icons.delete),
                      label: Text('${sorts.length.toString()} sorts'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    )
                ],
              ),
            ],
          ),
        );
      }
      return const SliverToBoxAdapter();
    },
  );

  BlocBuilder sectionJobOffersBuilder() => BlocBuilder<JobOfferBloc, JobOfferState>(
    builder:(context, state) {
      if (state is FetchedJobOfferState) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.hasMore
            ? state.jobOffers.length + 1
            : state.jobOffers.length,
            (context, index) => index >= state.jobOffers.length
            ? const BottomLoaderComponent()
            : Column(
                children: [
                  JobOfferCardComponent(jobOffer: state.jobOffers[index] as Recruitment),
                  const SizedBox(height: 16.0),
                ],
              ),
          ),
        );
      } else if (state is ErrorJobOfferState) {
        return Text('Errore -> ${state.errorMessage ?? 'Generic Error'}'); // Da sistemare
      } else if (state is NoJobOfferState) {
        return const Text('Nessuna pagina disponibile'); // Da sistemare
      } else if (state is FetchingJobOfferState) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 5,
            (context, index) => Column(
              children: const [
                JobOfferCardComponent(),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      }
      return const SliverToBoxAdapter();
    },
  );
}
