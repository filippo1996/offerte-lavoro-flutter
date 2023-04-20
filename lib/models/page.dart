import 'package:equatable/equatable.dart';
import 'package:offertelavoroflutter/services/network/notion/dto/page_properties.dart';

@Deprecated('Classe da eliminare')
class Page extends Equatable {
  final String id;
  final DateTime createdTime;
  final DateTime lastEditedTime;
  final Icon? icon;
  final List<Property?> properties;
  final String url;
  /*
  final CreatedByDTO createdBy;
  final LastEditedByDTO lastEditedBy;
  final CoverDTO? cover;
  final ParentDTO parent;
  final bool archived;
  */

  const Page({
    required this.id,
    required this.createdTime,
    required this.lastEditedTime,
    required this.icon,
    required this.properties,
    required this.url,
  });

  @override
  List<Object?> get props => [
    id,
    createdTime,
    lastEditedTime,
    icon,
    url,
    properties,
  ];
}

class Icon extends Equatable {
  final String type;
  final String emoji;

  const Icon({
    required this.type,
    required this.emoji,
  });

  @override
  List<Object?> get props => [type, emoji];
}

/// Page properties
abstract class Property extends Equatable {
  const Property();

  @override
  List<Object?> get props => [];
}

class CreatedTime extends Property {
  final String name;
  final String id;
  final String type;
  final DateTime createdTime;

  const CreatedTime({
    required this.name,
    required this.id,
    required this.type,
    required this.createdTime,
  });

  factory CreatedTime.toModel(CreatedTimeDTO dto) => CreatedTime(
    name: '',//dto.name,
    id: dto.id,
    type: dto.type,
    createdTime: dto.createdTime,
  );

  @override
  List<Object?> get props => [
    name,
    id,
    type,
    createdTime,
  ];
}

class Select extends Property {
  final String name;
  final String id;
  final String type;
  final SelectOption? selectOption;

  const Select({
    required this.name,
    required this.id,
    required this.type,
    required this.selectOption,
  });

  factory Select.toModel(SelectDTO dto) => Select(
    name: '',//dto.name,
    id: dto.id,
    type: dto.type,
    selectOption: dto.selectOption != null
      ? SelectOption(
          id: dto.selectOption!.id,
          name: dto.selectOption!.name,
          color: dto.selectOption!.color,
        )
      : null,
  );

  @override
  List<Object?> get props => [
    name,
    id,
    type,
    selectOption,
  ];
}

class SelectOption {
  final String id;
  final String name;
  final String color;

  const SelectOption({
    required this.id,
    required this.name,
    required this.color,
  });
}

class Title extends Property {
  final String field;
  final String id;
  final String type;
  final String plainText;

  const Title({
    required this.field,
    required this.id,
    required this.type,
    required this.plainText,
  });

  factory Title.toModel(TitleDTO dto) => Title(
    field: dto.field,
    id: dto.id,
    type: dto.type,
    plainText: ''//dto.plainText,
  );

  @override
  List<Object?> get props => [
    field,
    id,
    type,
    plainText,
  ];
}