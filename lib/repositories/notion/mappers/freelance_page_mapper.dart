import 'package:offertelavoroflutter/misc/mapper.dart';
import 'package:offertelavoroflutter/models/job_offer.dart';
//import 'package:offertelavoroflutter/models/page.dart';
import 'package:offertelavoroflutter/services/network/notion/dto/page.dart';
import 'package:offertelavoroflutter/services/network/notion/dto/page_properties.dart';
//import 'package:offertelavoroflutter/services/network/notion/dto/page_properties.dart';

/// The mapping is done with data from Notion
class FreelancePageMapper extends DTOMapper<PageDTO, Freelance> {
  @override
  PageDTO toDataTransfertObject(Freelance model) {
    throw UnimplementedError();
  }

  @override
  Freelance toModel(PageDTO dto) {
    throw UnimplementedError();
  }
/*
  Property? _propertyToModel(PagePropertiesDTO item) {
    switch(item.runtimeType) {
      case CreatedTimeDTO:
        return CreatedTime.toModel(item as CreatedTimeDTO);
      case SelectDTO:
        return Select.toModel(item as SelectDTO);
      default:
        return null;
    }
  }
  */

}