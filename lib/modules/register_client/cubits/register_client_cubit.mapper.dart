// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'register_client_cubit.dart';

class RegisterClientStateMapper extends ClassMapperBase<RegisterClientState> {
  RegisterClientStateMapper._();

  static RegisterClientStateMapper? _instance;
  static RegisterClientStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterClientStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterClientState';

  static String? _$rfid(RegisterClientState v) => v.rfid;
  static const Field<RegisterClientState, String> _f$rfid =
      Field('rfid', _$rfid);
  static bool _$isLoading(RegisterClientState v) => v.isLoading;
  static const Field<RegisterClientState, bool> _f$isLoading =
      Field('isLoading', _$isLoading);

  @override
  final Map<Symbol, Field<RegisterClientState, dynamic>> fields = const {
    #rfid: _f$rfid,
    #isLoading: _f$isLoading,
  };

  static RegisterClientState _instantiate(DecodingData data) {
    return RegisterClientState(data.dec(_f$rfid), data.dec(_f$isLoading));
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterClientState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterClientState>(map);
  }

  static RegisterClientState fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterClientState>(json);
  }
}

mixin RegisterClientStateMappable {
  String toJson() {
    return RegisterClientStateMapper.ensureInitialized()
        .encodeJson<RegisterClientState>(this as RegisterClientState);
  }

  Map<String, dynamic> toMap() {
    return RegisterClientStateMapper.ensureInitialized()
        .encodeMap<RegisterClientState>(this as RegisterClientState);
  }

  RegisterClientStateCopyWith<RegisterClientState, RegisterClientState,
          RegisterClientState>
      get copyWith => _RegisterClientStateCopyWithImpl(
          this as RegisterClientState, $identity, $identity);
  @override
  String toString() {
    return RegisterClientStateMapper.ensureInitialized()
        .stringifyValue(this as RegisterClientState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegisterClientStateMapper.ensureInitialized()
                .isValueEqual(this as RegisterClientState, other));
  }

  @override
  int get hashCode {
    return RegisterClientStateMapper.ensureInitialized()
        .hashValue(this as RegisterClientState);
  }
}

extension RegisterClientStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterClientState, $Out> {
  RegisterClientStateCopyWith<$R, RegisterClientState, $Out>
      get $asRegisterClientState =>
          $base.as((v, t, t2) => _RegisterClientStateCopyWithImpl(v, t, t2));
}

abstract class RegisterClientStateCopyWith<$R, $In extends RegisterClientState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? rfid, bool? isLoading});
  RegisterClientStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegisterClientStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterClientState, $Out>
    implements RegisterClientStateCopyWith<$R, RegisterClientState, $Out> {
  _RegisterClientStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterClientState> $mapper =
      RegisterClientStateMapper.ensureInitialized();
  @override
  $R call({Object? rfid = $none, bool? isLoading}) => $apply(FieldCopyWithData({
        if (rfid != $none) #rfid: rfid,
        if (isLoading != null) #isLoading: isLoading
      }));
  @override
  RegisterClientState $make(CopyWithData data) => RegisterClientState(
      data.get(#rfid, or: $value.rfid),
      data.get(#isLoading, or: $value.isLoading));

  @override
  RegisterClientStateCopyWith<$R2, RegisterClientState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _RegisterClientStateCopyWithImpl($value, $cast, t);
}
