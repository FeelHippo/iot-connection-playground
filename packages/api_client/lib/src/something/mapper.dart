import 'package:apiClient/src/dto/generic_dto.dart';
import 'package:apiClient/src/something/model.dart';

class SomethingMapper {
  SomethingMapper();

  SomethingModel map(GenericDto dto) {
    return SomethingModel(something: dto.name);
  }
}
