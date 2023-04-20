import 'package:offertelavoroflutter/interfaces/user_interface.dart';
import 'package:offertelavoroflutter/models/page.dart';

@Deprecated('Classe da eliminare')
class ShowPage {
  final Page page;

  const ShowPage({
    required this.page,
  });

  List<UserInterface> get sections => [
    if(page.icon != null) PageIconUI(page.icon!),
  ];
}

class PageIconUI implements UserInterface {
  final String emoji;

  PageIconUI(Icon icon) : emoji = icon.emoji;
}

/// Properties UI

class TitlesUI implements UserInterface {
  //final List<TitleUI> titles;
  /*
  TitlesUI(List<Property?> properties) : 
  titles = properties.where((property) => property)
  
  .toList(growable: false);
  */
}

class TitleUI implements UserInterface {
  final String plainText;

  TitleUI(propertyTitle) : plainText = 'Mobile developer Flutter | Gruppo Maggioli';
}


/*
final String id;
  final DateTime createdTime;
  final DateTime lastEditedTime;
  final Icon icon;
  final List<Property?> properties;
  final String url;
  */