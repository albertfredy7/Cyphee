import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'pin_record.g.dart';

abstract class PinRecord implements Built<PinRecord, PinRecordBuilder> {
  static Serializer<PinRecord> get serializer => _$pinRecordSerializer;

  int? get pin;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(PinRecordBuilder builder) => builder..pin = 0;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('pin')
          : FirebaseFirestore.instance.collectionGroup('pin');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('pin').doc();

  static Stream<PinRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PinRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PinRecord._();
  factory PinRecord([void Function(PinRecordBuilder) updates]) = _$PinRecord;

  static PinRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPinRecordData({
  int? pin,
}) {
  final firestoreData = serializers.toFirestore(
    PinRecord.serializer,
    PinRecord(
      (p) => p..pin = pin,
    ),
  );

  return firestoreData;
}
