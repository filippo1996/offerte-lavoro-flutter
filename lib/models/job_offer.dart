import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:offertelavoroflutter/services/network/notion/dto/page_properties.dart';
import 'package:offertelavoroflutter/ui/theme/colors.dart';

class Pagination extends Equatable {
  final List<JobOffer> results;
  final String? nextCursor;
  final bool hasMore;

  const Pagination({
    required this.results,
    required this.nextCursor,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [
    results,
    nextCursor,
    hasMore,
  ];
}

/// Generic class job offer 
class JobOffer extends Equatable {
  final String? name;
  final String? image;
  final DateTime? posted;
  final bool archived;
  final String? candidature;

  const JobOffer({
    required this.name,
    required this.image,
    required this.posted,
    required this.archived,
    required this.candidature,
  });

  @override
  List<Object?> get props => [
    name,
    image,
    posted,
    archived,
    candidature
  ];

  @override
  String toString() => 
  '''
  name: $name,
  image: $image,
  posted: $posted,
  archived: $archived,
  candidature: $candidature,
  ''';
}

/// Class recruitment jobs
class Recruitment extends JobOffer {
  final String? companyName;
  final String? urlWebsite;
  final String? qualification;
  final Detail? seniority;
  final Detail? team;
  final Detail? contract;
  final String? pay;
  final String? ral;
  final List<Description>? offerDescription;
  final String? locality;

  const Recruitment({
    required this.companyName,
    required this.urlWebsite,
    required this.qualification,
    required this.seniority,
    required this.team,
    required this.contract,
    required this.pay,
    required this.ral,
    required this.offerDescription,
    required this.locality,
    required super.name, 
    required super.image,
    required super.posted, 
    required super.archived, 
    required super.candidature,
  });

  @override
  List<Object?> get props => super.props..addAll([
    companyName,
    urlWebsite,
    qualification,
    seniority,
    team,
    contract,
    pay,
    ral,
    offerDescription,
    locality,
  ]);

  @override
  String toString() => 
  '''
  ${super.toString()}
  companyName: $companyName,
  urlWebsite: $urlWebsite,
  qualification: $qualification,
  seniority: $seniority,
  team: $team,
  contract: $contract,
  pay: $pay,
  ral: $ral,
  offerDescription: $offerDescription,
  locality: $locality,
  ''';
}

/// class freelance jobs
class Freelance extends JobOffer {
  final String? projectDescription;
  final String? workRequest;
  final String? relationshipType;
  final String? timing;
  final String? budget;
  final String? paymentTimes;
  final String? nda;

  const Freelance({
    required super.name,
    required super.image,
    required super.posted,
    required super.archived,
    required super.candidature,
    required this.projectDescription,
    required this.workRequest,
    required this.relationshipType,
    required this.timing,
    required this.budget,
    required this.paymentTimes,
    required this.nda
  });

  @override
  List<Object?> get props => super.props..addAll([
    projectDescription,
    workRequest,
    relationshipType,
    timing,
    budget,
    paymentTimes,
    nda
  ]);

  @override
  String toString() => 
  '''
  ${super.toString()}
  projectDescription: $projectDescription,
  workRequest: $workRequest,
  relationshipType: $relationshipType,
  timing: $timing,
  budget: $budget,
  paymentTimes: $paymentTimes,
  nda: $nda,
  ''';
}

class Description extends Equatable {
  final String text;
  final Annotation annotations;

  const Description({
    required this.text,
    required this.annotations,
  });

  factory Description.toModel(BodyRichTextDTO dto) => Description(
    text: dto.plainText,
    annotations: Annotation(
      bold: dto.annotations.bold,
      italic: dto.annotations.italic,
      strikethrough: dto.annotations.strikethrough,
      underline: dto.annotations.underline,
      code: dto.annotations.code,
      color: dto.annotations.color,
    ),
  );

  @override
  List<Object?> get props => [text, annotations];
}

class Annotation extends Equatable {
  final bool bold;
  final bool italic;
  final bool strikethrough;
  final bool underline;
  final bool code;
  final String color;

  const Annotation({
    required this.bold,
    required this.italic,
    required this.strikethrough,
    required this.underline,
    required this.code,
    required this.color,
  });

  @override
  List<Object?> get props => [
    bold,
    italic,
    strikethrough,
    underline,
    code,
    color,
  ];
}

class Detail extends Equatable {
  final String? text;
  final Color? color;

  const Detail({
    required this.text,
    required this.color,
  });

  factory Detail.toModel(SelectDTO? dto) => Detail(
    text: dto?.selectOption?.name,
    color: dto?.selectOption?.color != null 
      ? ThemeColors.color[dto?.selectOption?.color]
      : ThemeColors.color['default'], // Default color
  );

  @override
  List<Object?> get props => [text, color];
}