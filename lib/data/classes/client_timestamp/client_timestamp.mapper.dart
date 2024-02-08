// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'client_timestamp.dart';

class ClientTimestampMapper extends ClassMapperBase<ClientTimestamp> {
  ClientTimestampMapper._();

  static ClientTimestampMapper? _instance;
  static ClientTimestampMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientTimestampMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ClientTimestamp';

  static int? _$id(ClientTimestamp v) => v.id;
  static const Field<ClientTimestamp, int> _f$id = Field('id', _$id);
  static int _$clientId(ClientTimestamp v) => v.clientId;
  static const Field<ClientTimestamp, int> _f$clientId =
      Field('clientId', _$clientId);
  static DateTime _$timestamp(ClientTimestamp v) => v.timestamp;
  static const Field<ClientTimestamp, DateTime> _f$timestamp =
      Field('timestamp', _$timestamp);

  @override
  final Map<Symbol, Field<ClientTimestamp, dynamic>> fields = const {
    #id: _f$id,
    #clientId: _f$clientId,
    #timestamp: _f$timestamp,
  };
  @override
  final bool ignoreNull = true;

  @override
  final MappingHook hook = const _Hook();
  static ClientTimestamp _instantiate(DecodingData data) {
    return ClientTimestamp(
        data.dec(_f$id), data.dec(_f$clientId), data.dec(_f$timestamp));
  }

  @override
  final Function instantiate = _instantiate;

  static ClientTimestamp fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientTimestamp>(map);
  }

  static ClientTimestamp fromJson(String json) {
    return ensureInitialized().decodeJson<ClientTimestamp>(json);
  }
}

mixin ClientTimestampMappable {
  String toJson() {
    return ClientTimestampMapper.ensureInitialized()
        .encodeJson<ClientTimestamp>(this as ClientTimestamp);
  }

  Map<String, dynamic> toMap() {
    return ClientTimestampMapper.ensureInitialized()
        .encodeMap<ClientTimestamp>(this as ClientTimestamp);
  }

  ClientTimestampCopyWith<ClientTimestamp, ClientTimestamp, ClientTimestamp>
      get copyWith => _ClientTimestampCopyWithImpl(
          this as ClientTimestamp, $identity, $identity);
  @override
  String toString() {
    return ClientTimestampMapper.ensureInitialized()
        .stringifyValue(this as ClientTimestamp);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ClientTimestampMapper.ensureInitialized()
                .isValueEqual(this as ClientTimestamp, other));
  }

  @override
  int get hashCode {
    return ClientTimestampMapper.ensureInitialized()
        .hashValue(this as ClientTimestamp);
  }
}

extension ClientTimestampValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClientTimestamp, $Out> {
  ClientTimestampCopyWith<$R, ClientTimestamp, $Out> get $asClientTimestamp =>
      $base.as((v, t, t2) => _ClientTimestampCopyWithImpl(v, t, t2));
}

abstract class ClientTimestampCopyWith<$R, $In extends ClientTimestamp, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, int? clientId, DateTime? timestamp});
  ClientTimestampCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ClientTimestampCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClientTimestamp, $Out>
    implements ClientTimestampCopyWith<$R, ClientTimestamp, $Out> {
  _ClientTimestampCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClientTimestamp> $mapper =
      ClientTimestampMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, int? clientId, DateTime? timestamp}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (clientId != null) #clientId: clientId,
        if (timestamp != null) #timestamp: timestamp
      }));
  @override
  ClientTimestamp $make(CopyWithData data) => ClientTimestamp(
      data.get(#id, or: $value.id),
      data.get(#clientId, or: $value.clientId),
      data.get(#timestamp, or: $value.timestamp));

  @override
  ClientTimestampCopyWith<$R2, ClientTimestamp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientTimestampCopyWithImpl($value, $cast, t);
}
