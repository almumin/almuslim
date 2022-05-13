// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/app-context.dart';
import 'models/quran-entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7764714462544937502),
      name: 'QuranAyah',
      lastPropertyId: const IdUid(5, 823086920123750362),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6872092311447497324),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1368515039137800596),
            name: 'surahNumber',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6950827306546038413),
            name: 'ayahNumber',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1642707768174414378),
            name: 'text',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 823086920123750362),
            name: 'englishText',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 7214744480193890939),
      name: 'AppContext',
      lastPropertyId: const IdUid(5, 7474378556238101246),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6107345605398642440),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 3833497024695475614),
            name: 'language',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1013211941853219768),
            name: 'theme',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4505056168950788936),
            name: 'calculationMethod',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7474378556238101246),
            name: 'madhab',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String directory,
        int maxDBSizeInKB,
        int fileMode,
        int maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 7214744480193890939),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    QuranAyah: EntityDefinition<QuranAyah>(
        model: _entities[0],
        toOneRelations: (QuranAyah object) => [],
        toManyRelations: (QuranAyah object) => {},
        getId: (QuranAyah object) => object.id,
        setId: (QuranAyah object, int id) {
          object.id = id;
        },
        objectToFB: (QuranAyah object, fb.Builder fbb) {
          final textOffset =
              object.text == null ? null : fbb.writeString(object.text);
          final englishTextOffset = object.englishText == null
              ? null
              : fbb.writeString(object.englishText);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.surahNumber);
          fbb.addInt64(2, object.ayahNumber);
          fbb.addOffset(3, textOffset);
          fbb.addOffset(4, englishTextOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = QuranAyah()
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
            ..surahNumber =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 6)
            ..ayahNumber =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8)
            ..text = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 10)
            ..englishText = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 12);

          return object;
        }),
    AppContext: EntityDefinition<AppContext>(
        model: _entities[1],
        toOneRelations: (AppContext object) => [],
        toManyRelations: (AppContext object) => {},
        getId: (AppContext object) => object.id,
        setId: (AppContext object, int id) {
          object.id = id;
        },
        objectToFB: (AppContext object, fb.Builder fbb) {
          final languageOffset =
              object.language == null ? null : fbb.writeString(object.language);
          final themeOffset =
              object.theme == null ? null : fbb.writeString(object.theme);
          final calculationMethodOffset = object.calculationMethod == null
              ? null
              : fbb.writeString(object.calculationMethod);
          final madhabOffset =
              object.madhab == null ? null : fbb.writeString(object.madhab);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, languageOffset);
          fbb.addOffset(2, themeOffset);
          fbb.addOffset(3, calculationMethodOffset);
          fbb.addOffset(4, madhabOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = AppContext(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8))
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
            ..calculationMethod = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 10)
            ..madhab = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 12);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [QuranAyah] entity fields to define ObjectBox queries.
class QuranAyah_ {
  /// see [QuranAyah.id]
  static final id = QueryIntegerProperty<QuranAyah>(_entities[0].properties[0]);

  /// see [QuranAyah.surahNumber]
  static final surahNumber =
      QueryIntegerProperty<QuranAyah>(_entities[0].properties[1]);

  /// see [QuranAyah.ayahNumber]
  static final ayahNumber =
      QueryIntegerProperty<QuranAyah>(_entities[0].properties[2]);

  /// see [QuranAyah.text]
  static final text =
      QueryStringProperty<QuranAyah>(_entities[0].properties[3]);

  /// see [QuranAyah.englishText]
  static final englishText =
      QueryStringProperty<QuranAyah>(_entities[0].properties[4]);
}

/// [AppContext] entity fields to define ObjectBox queries.
class AppContext_ {
  /// see [AppContext.id]
  static final id =
      QueryIntegerProperty<AppContext>(_entities[1].properties[0]);

  /// see [AppContext.language]
  static final language =
      QueryStringProperty<AppContext>(_entities[1].properties[1]);

  /// see [AppContext.theme]
  static final theme =
      QueryStringProperty<AppContext>(_entities[1].properties[2]);

  /// see [AppContext.calculationMethod]
  static final calculationMethod =
      QueryStringProperty<AppContext>(_entities[1].properties[3]);

  /// see [AppContext.madhab]
  static final madhab =
      QueryStringProperty<AppContext>(_entities[1].properties[4]);
}
