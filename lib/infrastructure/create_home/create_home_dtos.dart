import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cybear_jinni/domain/create_home/create_home_entity.dart';
import 'package:cybear_jinni/domain/create_home/create_home_value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_home_dtos.freezed.dart';
part 'create_home_dtos.g.dart';

@freezed
abstract class CreateHomeDtos implements _$CreateHomeDtos {
  const CreateHomeDtos._();

  const factory CreateHomeDtos({
    @JsonKey(ignore: true) String id,
    @JsonKey(ignore: true) String name,
    @required String homeDevicesUserEmail,
    @required String homeDevicesUserPassword,
    @required @ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _CreateHomeDtos;

  factory CreateHomeDtos.fromDomain(CreateHomeEntity createHomeEntity) {
    return CreateHomeDtos(
      homeDevicesUserEmail: createHomeEntity.homeDevicesUserEmail.getOrCrash(),
      homeDevicesUserPassword:
          createHomeEntity.homeDevicesUserPassword.getOrCrash(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  CreateHomeEntity toDomain() {
    return CreateHomeEntity(
      name: HomeName(' '),
      id: HomeUniqueId.fromUniqueString(' '),
      homeDevicesUserEmail: HomeDevicesUserEmail(homeDevicesUserEmail),
      homeDevicesUserPassword:
          HomeDevicesUserPassword.fromUniqueString(homeDevicesUserPassword),
    );
  }

  factory CreateHomeDtos.fromJson(Map<String, dynamic> json) =>
      _$CreateHomeDtosFromJson(json);

  factory CreateHomeDtos.fromFirestore(DocumentSnapshot doc) {
    return CreateHomeDtos.fromJson(doc.data()).copyWith(id: doc.id);
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}