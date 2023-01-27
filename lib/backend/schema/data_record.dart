import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'data_record.g.dart';

abstract class DataRecord implements Built<DataRecord, DataRecordBuilder> {
  static Serializer<DataRecord> get serializer => _$dataRecordSerializer;

  String? get username;

  String? get password;

  String? get url;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(DataRecordBuilder builder) => builder
    ..username = ''
    ..password = ''
    ..url = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('data')
          : FirebaseFirestore.instance.collectionGroup('data');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('data').doc();

  static Stream<DataRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<DataRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  DataRecord._();
  factory DataRecord([void Function(DataRecordBuilder) updates]) = _$DataRecord;

  static DataRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createDataRecordData({
  String? username,
  String? password,
  String? url,
}) {
  final firestoreData = serializers.toFirestore(
    DataRecord.serializer,
    DataRecord(
      (d) => d
        ..username = username
        ..password = password
        ..url = url,
    ),
  );

  return firestoreData;
}
