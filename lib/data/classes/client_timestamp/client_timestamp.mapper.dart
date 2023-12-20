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

  static String _$rfid(ClientTimestamp v) => v.rfid;
  static const Field<ClientTimestamp, String> _f$rfid = Field('rfid', _$rfid);
  static List<DateTime> _$timestamps(ClientTimestamp v) => v.timestamps;
  static const Field<ClientTimestamp, List<DateTime>> _f$timestamps =
      Field('timestamps', _$timestamps);

  @override
  final Map<Symbol, Field<ClientTimestamp, dynamic>> fields = const {
    #rfid: _f$rfid,
    #timestamps: _f$timestamps,
  };

  static ClientTimestamp _instantiate(DecodingData data) {
    return ClientTimestamp(
        rfid: data.dec(_f$rfid), timestamps: data.dec(_f$timestamps));
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
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get timestamps;
  $R call({String? rfid, List<DateTime>? timestamps});
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
  ListCopyWith<$R, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
      get timestamps => ListCopyWith(
          $value.timestamps,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(timestamps: v));
  @override
  $R call({String? rfid, List<DateTime>? timestamps}) =>
      $apply(FieldCopyWithData({
        if (rfid != null) #rfid: rfid,
        if (timestamps != null) #timestamps: timestamps
      }));
  @override
  ClientTimestamp $make(CopyWithData data) => ClientTimestamp(
      rfid: data.get(#rfid, or: $value.rfid),
      timestamps: data.get(#timestamps, or: $value.timestamps));

  @override
  ClientTimestampCopyWith<$R2, ClientTimestamp, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientTimestampCopyWithImpl($value, $cast, t);
}
