// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PinRecord> _$pinRecordSerializer = new _$PinRecordSerializer();

class _$PinRecordSerializer implements StructuredSerializer<PinRecord> {
  @override
  final Iterable<Type> types = const [PinRecord, _$PinRecord];
  @override
  final String wireName = 'PinRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, PinRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.pin;
    if (value != null) {
      result
        ..add('pin')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  PinRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PinRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pin':
          result.pin = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$PinRecord extends PinRecord {
  @override
  final int? pin;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$PinRecord([void Function(PinRecordBuilder)? updates]) =>
      (new PinRecordBuilder()..update(updates))._build();

  _$PinRecord._({this.pin, this.ffRef}) : super._();

  @override
  PinRecord rebuild(void Function(PinRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PinRecordBuilder toBuilder() => new PinRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PinRecord && pin == other.pin && ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, pin.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PinRecord')
          ..add('pin', pin)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class PinRecordBuilder implements Builder<PinRecord, PinRecordBuilder> {
  _$PinRecord? _$v;

  int? _pin;
  int? get pin => _$this._pin;
  set pin(int? pin) => _$this._pin = pin;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  PinRecordBuilder() {
    PinRecord._initializeBuilder(this);
  }

  PinRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pin = $v.pin;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PinRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PinRecord;
  }

  @override
  void update(void Function(PinRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PinRecord build() => _build();

  _$PinRecord _build() {
    final _$result = _$v ?? new _$PinRecord._(pin: pin, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
