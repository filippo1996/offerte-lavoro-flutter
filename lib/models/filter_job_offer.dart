import 'package:equatable/equatable.dart';
import 'package:offertelavoroflutter/utils/extensions/enum_extension.dart';

class FilterJobOffer extends Equatable{
  final List<Sort>? sorts;
  final String? startCursor;

  const FilterJobOffer({
    this.sorts,
    this.startCursor,
  });

  @override
  List<Object?> get props => [sorts, startCursor];

  Map<String, dynamic> toJson([bool removePropertyNull = false]) {
    Map<String, dynamic> json = {
      "sorts": sorts?.map((sort) => sort.toJson(removePropertyNull))
        .toList(growable: false),
      "start_cursor": startCursor,
    };
    if (removePropertyNull) {
      return json..removeWhere((key, value) => value == null);
    }
    return json;
  }

  FilterJobOffer copyWith({
    final List<Sort>? sorts,
    final String? startCursor,
  }) {
    return FilterJobOffer(
      sorts: sorts ?? this.sorts,
      startCursor: startCursor ?? this.startCursor,
    );
  }

  /// I valori di queste proprietà statiche per i filtri, è raccomandato
  /// di ottenerli tramite API, in assenza di tale API
  /// momentaneamente si impostatano staticamente.
  static const properties = [
    'Job Posted',
    'Name',
  ];

  static const sortDirection = [
    'ascending',
    'descending',
  ];

  static const timestamp = [
    'created_time',
    'last_edited_time',
  ];
}

class Sort extends Equatable {
  final String? property;
  final Direction direction;
  final Timestamp? timestamp;

  const Sort({
    this.property,
    required this.direction,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
    property,
    timestamp,
  ];

  Map<String, dynamic> toJson([bool removePropertyNull = false]) {
    Map<String, dynamic> json = {
      "property": property,
      "direction": direction.toShortString(),
      "timestamp": timestamp?.toShortString(),
    };
    if (removePropertyNull) {
      return json..removeWhere((key, value) => value == null);
    }
    return json;
  }
}

enum Direction {ascending, descending}

enum Timestamp {created_time, last_edited_time}