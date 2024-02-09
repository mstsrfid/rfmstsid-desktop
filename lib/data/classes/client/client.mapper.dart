// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'client.dart';

class ClientMapper extends ClassMapperBase<Client> {
  ClientMapper._();

  static ClientMapper? _instance;
  static ClientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Client';

  static int? _$id(Client v) => v.id;
  static const Field<Client, int> _f$id = Field('id', _$id);
  static String _$rfid(Client v) => v.rfid;
  static const Field<Client, String> _f$rfid = Field('rfid', _$rfid);
  static String _$ime(Client v) => v.ime;
  static const Field<Client, String> _f$ime = Field('ime', _$ime);
  static String _$prezime(Client v) => v.prezime;
  static const Field<Client, String> _f$prezime = Field('prezime', _$prezime);
  static int _$isPresent(Client v) => v.isPresent;
  static const Field<Client, int> _f$isPresent =
      Field('isPresent', _$isPresent);

  @override
  final Map<Symbol, Field<Client, dynamic>> fields = const {
    #id: _f$id,
    #rfid: _f$rfid,
    #ime: _f$ime,
    #prezime: _f$prezime,
    #isPresent: _f$isPresent,
  };
  @override
  final bool ignoreNull = true;

  static Client _instantiate(DecodingData data) {
    return Client(
        id: data.dec(_f$id),
        rfid: data.dec(_f$rfid),
        ime: data.dec(_f$ime),
        prezime: data.dec(_f$prezime),
        isPresent: data.dec(_f$isPresent));
  }

  @override
  final Function instantiate = _instantiate;

  static Client fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Client>(map);
  }

  static Client fromJson(String json) {
    return ensureInitialized().decodeJson<Client>(json);
  }
}

mixin ClientMappable {
  String toJson() {
    return ClientMapper.ensureInitialized().encodeJson<Client>(this as Client);
  }

  Map<String, dynamic> toMap() {
    return ClientMapper.ensureInitialized().encodeMap<Client>(this as Client);
  }

  ClientCopyWith<Client, Client, Client> get copyWith =>
      _ClientCopyWithImpl(this as Client, $identity, $identity);
  @override
  String toString() {
    return ClientMapper.ensureInitialized().stringifyValue(this as Client);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ClientMapper.ensureInitialized()
                .isValueEqual(this as Client, other));
  }

  @override
  int get hashCode {
    return ClientMapper.ensureInitialized().hashValue(this as Client);
  }
}

extension ClientValueCopy<$R, $Out> on ObjectCopyWith<$R, Client, $Out> {
  ClientCopyWith<$R, Client, $Out> get $asClient =>
      $base.as((v, t, t2) => _ClientCopyWithImpl(v, t, t2));
}

abstract class ClientCopyWith<$R, $In extends Client, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id, String? rfid, String? ime, String? prezime, int? isPresent});
  ClientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ClientCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Client, $Out>
    implements ClientCopyWith<$R, Client, $Out> {
  _ClientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Client> $mapper = ClientMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? rfid,
          String? ime,
          String? prezime,
          int? isPresent}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (rfid != null) #rfid: rfid,
        if (ime != null) #ime: ime,
        if (prezime != null) #prezime: prezime,
        if (isPresent != null) #isPresent: isPresent
      }));
  @override
  Client $make(CopyWithData data) => Client(
      id: data.get(#id, or: $value.id),
      rfid: data.get(#rfid, or: $value.rfid),
      ime: data.get(#ime, or: $value.ime),
      prezime: data.get(#prezime, or: $value.prezime),
      isPresent: data.get(#isPresent, or: $value.isPresent));

  @override
  ClientCopyWith<$R2, Client, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ClientCopyWithImpl($value, $cast, t);
}
