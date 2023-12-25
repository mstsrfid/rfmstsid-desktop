// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'client_timestamps.dart';

class ClientTimestampsMapper extends ClassMapperBase<ClientTimestamps> {
  ClientTimestampsMapper._();

  static ClientTimestampsMapper? _instance;
  static ClientTimestampsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientTimestampsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ClientTimestamps';

  static String _$id(ClientTimestamps v) => v.id;
  static const Field<ClientTimestamps, String> _f$id = Field('id', _$id);
  static List<DateTime> _$timestamps(ClientTimestamps v) => v.timestamps;
  static const Field<ClientTimestamps, List<DateTime>> _f$timestamps =
      Field('timestamps', _$timestamps);

  @override
  final Map<Symbol, Field<ClientTimestamps, dynamic>> fields = const {
    #id: _f$id,
    #timestamps: _f$timestamps,
  };

  static ClientTimestamps _instantiate(DecodingData data) {
    return ClientTimestamps(data.dec(_f$id), data.dec(_f$timestamps));
  }

  @override
  final Function instantiate = _instantiate;

  static ClientTimestamps fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientTimestamps>(map);
  }

  static ClientTimestamps fromJson(String json) {
    return ensureInitialized().decodeJson<ClientTimestamps>(json);
  }
}

mixin ClientTimestampsMappable {
  String toJson() {
    return ClientTimestampsMapper.ensureInitialized()
        .encodeJson<ClientTimestamps>(this as ClientTimestamps);
  }

  Map<String, dynamic> toMap() {
    return ClientTimestampsMapper.ensureInitialized()
        .encodeMap<ClientTimestamps>(this as ClientTimestamps);
  }

  ClientTimestampsCopyWith<ClientTimestamps, ClientTimestamps, ClientTimestamps>
      get copyWith => _ClientTimestampsCopyWithImpl(
          this as ClientTimestamps, $identity, $identity);
  @override
  String toString() {
    return ClientTimestampsMapper.ensureInitialized()
        .stringifyValue(this as ClientTimestamps);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ClientTimestampsMapper.ensureInitialized()
                .isValueEqual(this as ClientTimestamps, other));
  }

  @override
  int get hashCode {
    return ClientTimestampsMapper.ensureInitialized()
        .hashValue(this as ClientTimestamps);
  }
}

extension ClientTimestampsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClientTimestamps, $Out> {
  ClientTimestampsCopyWith<$R, ClientTimestamps, $Out>
      get $asClientTimestamps =>
          $base.as((v, t, t2) => _ClientTimestampsCopyWithImpl(v, t, t2));
}

abstract class ClientTimestampsCopyWith<$R, $In extends ClientTimestamps, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get timestamps;
  $R call({String? id, List<DateTime>? timestamps});
  ClientTimestampsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ClientTimestampsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClientTimestamps, $Out>
    implements ClientTimestampsCopyWith<$R, ClientTimestamps, $Out> {
  _ClientTimestampsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClientTimestamps> $mapper =
      ClientTimestampsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get timestamps => ListCopyWith(
          $value.timestamps,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(timestamps: v));
  @override
  $R call({String? id, List<DateTime>? timestamps}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (timestamps != null) #timestamps: timestamps
      }));
  @override
  ClientTimestamps $make(CopyWithData data) => ClientTimestamps(
      data.get(#id, or: $value.id),
      data.get(#timestamps, or: $value.timestamps));

  @override
  ClientTimestampsCopyWith<$R2, ClientTimestamps, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientTimestampsCopyWithImpl($value, $cast, t);
}
