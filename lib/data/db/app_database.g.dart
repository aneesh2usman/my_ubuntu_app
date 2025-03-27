// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TypeTableTable extends TypeTable
    with TableInfo<$TypeTableTable, TypeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, typeName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'type_table';
  @override
  VerificationContext validateIntegrity(Insertable<TypeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
    );
  }

  @override
  $TypeTableTable createAlias(String alias) {
    return $TypeTableTable(attachedDatabase, alias);
  }
}

class TypeTableData extends DataClass implements Insertable<TypeTableData> {
  final int id;
  final String typeName;
  const TypeTableData({required this.id, required this.typeName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type_name'] = Variable<String>(typeName);
    return map;
  }

  TypeTableCompanion toCompanion(bool nullToAbsent) {
    return TypeTableCompanion(
      id: Value(id),
      typeName: Value(typeName),
    );
  }

  factory TypeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeTableData(
      id: serializer.fromJson<int>(json['id']),
      typeName: serializer.fromJson<String>(json['typeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'typeName': serializer.toJson<String>(typeName),
    };
  }

  TypeTableData copyWith({int? id, String? typeName}) => TypeTableData(
        id: id ?? this.id,
        typeName: typeName ?? this.typeName,
      );
  TypeTableData copyWithCompanion(TypeTableCompanion data) {
    return TypeTableData(
      id: data.id.present ? data.id.value : this.id,
      typeName: data.typeName.present ? data.typeName.value : this.typeName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeTableData(')
          ..write('id: $id, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, typeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeTableData &&
          other.id == this.id &&
          other.typeName == this.typeName);
}

class TypeTableCompanion extends UpdateCompanion<TypeTableData> {
  final Value<int> id;
  final Value<String> typeName;
  const TypeTableCompanion({
    this.id = const Value.absent(),
    this.typeName = const Value.absent(),
  });
  TypeTableCompanion.insert({
    this.id = const Value.absent(),
    required String typeName,
  }) : typeName = Value(typeName);
  static Insertable<TypeTableData> custom({
    Expression<int>? id,
    Expression<String>? typeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (typeName != null) 'type_name': typeName,
    });
  }

  TypeTableCompanion copyWith({Value<int>? id, Value<String>? typeName}) {
    return TypeTableCompanion(
      id: id ?? this.id,
      typeName: typeName ?? this.typeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypeTableCompanion(')
          ..write('id: $id, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }
}

class $TaskTableTable extends TaskTable
    with TableInfo<$TaskTableTable, TaskTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES type_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, title, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaskTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $TaskTableTable createAlias(String alias) {
    return $TaskTableTable(attachedDatabase, alias);
  }
}

class TaskTableData extends DataClass implements Insertable<TaskTableData> {
  final int id;
  final String title;
  final int type;
  const TaskTableData(
      {required this.id, required this.title, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<int>(type);
    return map;
  }

  TaskTableCompanion toCompanion(bool nullToAbsent) {
    return TaskTableCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
    );
  }

  factory TaskTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<int>(type),
    };
  }

  TaskTableData copyWith({int? id, String? title, int? type}) => TaskTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
      );
  TaskTableData copyWithCompanion(TaskTableCompanion data) {
    return TaskTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type);
}

class TaskTableCompanion extends UpdateCompanion<TaskTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> type;
  const TaskTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
  });
  TaskTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int type,
  })  : title = Value(title),
        type = Value(type);
  static Insertable<TaskTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
    });
  }

  TaskTableCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<int>? type}) {
    return TaskTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $AttendantTableTable extends AttendantTable
    with TableInfo<$AttendantTableTable, AttendantTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendantTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
      'task_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES task_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, taskId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendant_table';
  @override
  VerificationContext validateIntegrity(Insertable<AttendantTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendantTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendantTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_id'])!,
    );
  }

  @override
  $AttendantTableTable createAlias(String alias) {
    return $AttendantTableTable(attachedDatabase, alias);
  }
}

class AttendantTableData extends DataClass
    implements Insertable<AttendantTableData> {
  final int id;
  final String name;
  final int taskId;
  const AttendantTableData(
      {required this.id, required this.name, required this.taskId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['task_id'] = Variable<int>(taskId);
    return map;
  }

  AttendantTableCompanion toCompanion(bool nullToAbsent) {
    return AttendantTableCompanion(
      id: Value(id),
      name: Value(name),
      taskId: Value(taskId),
    );
  }

  factory AttendantTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendantTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      taskId: serializer.fromJson<int>(json['taskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'taskId': serializer.toJson<int>(taskId),
    };
  }

  AttendantTableData copyWith({int? id, String? name, int? taskId}) =>
      AttendantTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        taskId: taskId ?? this.taskId,
      );
  AttendantTableData copyWithCompanion(AttendantTableCompanion data) {
    return AttendantTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendantTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, taskId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendantTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.taskId == this.taskId);
}

class AttendantTableCompanion extends UpdateCompanion<AttendantTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> taskId;
  const AttendantTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.taskId = const Value.absent(),
  });
  AttendantTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int taskId,
  })  : name = Value(name),
        taskId = Value(taskId);
  static Insertable<AttendantTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? taskId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (taskId != null) 'task_id': taskId,
    });
  }

  AttendantTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? taskId}) {
    return AttendantTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      taskId: taskId ?? this.taskId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendantTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TypeTableTable typeTable = $TypeTableTable(this);
  late final $TaskTableTable taskTable = $TaskTableTable(this);
  late final $AttendantTableTable attendantTable = $AttendantTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [typeTable, taskTable, attendantTable];
}

typedef $$TypeTableTableCreateCompanionBuilder = TypeTableCompanion Function({
  Value<int> id,
  required String typeName,
});
typedef $$TypeTableTableUpdateCompanionBuilder = TypeTableCompanion Function({
  Value<int> id,
  Value<String> typeName,
});

final class $$TypeTableTableReferences
    extends BaseReferences<_$AppDatabase, $TypeTableTable, TypeTableData> {
  $$TypeTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskTableTable, List<TaskTableData>>
      _taskTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.taskTable,
          aliasName: $_aliasNameGenerator(db.typeTable.id, db.taskTable.type));

  $$TaskTableTableProcessedTableManager get taskTableRefs {
    final manager = $$TaskTableTableTableManager($_db, $_db.taskTable)
        .filter((f) => f.type.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TypeTableTableFilterComposer
    extends Composer<_$AppDatabase, $TypeTableTable> {
  $$TypeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get typeName => $composableBuilder(
      column: $table.typeName, builder: (column) => ColumnFilters(column));

  Expression<bool> taskTableRefs(
      Expression<bool> Function($$TaskTableTableFilterComposer f) f) {
    final $$TaskTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTable,
        getReferencedColumn: (t) => t.type,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTableTableFilterComposer(
              $db: $db,
              $table: $db.taskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TypeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TypeTableTable> {
  $$TypeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get typeName => $composableBuilder(
      column: $table.typeName, builder: (column) => ColumnOrderings(column));
}

class $$TypeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypeTableTable> {
  $$TypeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get typeName =>
      $composableBuilder(column: $table.typeName, builder: (column) => column);

  Expression<T> taskTableRefs<T extends Object>(
      Expression<T> Function($$TaskTableTableAnnotationComposer a) f) {
    final $$TaskTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskTable,
        getReferencedColumn: (t) => t.type,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTableTableAnnotationComposer(
              $db: $db,
              $table: $db.taskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TypeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TypeTableTable,
    TypeTableData,
    $$TypeTableTableFilterComposer,
    $$TypeTableTableOrderingComposer,
    $$TypeTableTableAnnotationComposer,
    $$TypeTableTableCreateCompanionBuilder,
    $$TypeTableTableUpdateCompanionBuilder,
    (TypeTableData, $$TypeTableTableReferences),
    TypeTableData,
    PrefetchHooks Function({bool taskTableRefs})> {
  $$TypeTableTableTableManager(_$AppDatabase db, $TypeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> typeName = const Value.absent(),
          }) =>
              TypeTableCompanion(
            id: id,
            typeName: typeName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String typeName,
          }) =>
              TypeTableCompanion.insert(
            id: id,
            typeName: typeName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TypeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (taskTableRefs) db.taskTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskTableRefs)
                    await $_getPrefetchedData<TypeTableData, $TypeTableTable,
                            TaskTableData>(
                        currentTable: table,
                        referencedTable:
                            $$TypeTableTableReferences._taskTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TypeTableTableReferences(db, table, p0)
                                .taskTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.type == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TypeTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TypeTableTable,
    TypeTableData,
    $$TypeTableTableFilterComposer,
    $$TypeTableTableOrderingComposer,
    $$TypeTableTableAnnotationComposer,
    $$TypeTableTableCreateCompanionBuilder,
    $$TypeTableTableUpdateCompanionBuilder,
    (TypeTableData, $$TypeTableTableReferences),
    TypeTableData,
    PrefetchHooks Function({bool taskTableRefs})>;
typedef $$TaskTableTableCreateCompanionBuilder = TaskTableCompanion Function({
  Value<int> id,
  required String title,
  required int type,
});
typedef $$TaskTableTableUpdateCompanionBuilder = TaskTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> type,
});

final class $$TaskTableTableReferences
    extends BaseReferences<_$AppDatabase, $TaskTableTable, TaskTableData> {
  $$TaskTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TypeTableTable _typeTable(_$AppDatabase db) => db.typeTable
      .createAlias($_aliasNameGenerator(db.taskTable.type, db.typeTable.id));

  $$TypeTableTableProcessedTableManager get type {
    final $_column = $_itemColumn<int>('type')!;

    final manager = $$TypeTableTableTableManager($_db, $_db.typeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AttendantTableTable, List<AttendantTableData>>
      _attendantTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.attendantTable,
              aliasName: $_aliasNameGenerator(
                  db.taskTable.id, db.attendantTable.taskId));

  $$AttendantTableTableProcessedTableManager get attendantTableRefs {
    final manager = $$AttendantTableTableTableManager($_db, $_db.attendantTable)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendantTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TaskTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskTableTable> {
  $$TaskTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  $$TypeTableTableFilterComposer get type {
    final $$TypeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.type,
        referencedTable: $db.typeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TypeTableTableFilterComposer(
              $db: $db,
              $table: $db.typeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> attendantTableRefs(
      Expression<bool> Function($$AttendantTableTableFilterComposer f) f) {
    final $$AttendantTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attendantTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttendantTableTableFilterComposer(
              $db: $db,
              $table: $db.attendantTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TaskTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskTableTable> {
  $$TaskTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  $$TypeTableTableOrderingComposer get type {
    final $$TypeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.type,
        referencedTable: $db.typeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TypeTableTableOrderingComposer(
              $db: $db,
              $table: $db.typeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTableTable> {
  $$TaskTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  $$TypeTableTableAnnotationComposer get type {
    final $$TypeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.type,
        referencedTable: $db.typeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TypeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.typeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> attendantTableRefs<T extends Object>(
      Expression<T> Function($$AttendantTableTableAnnotationComposer a) f) {
    final $$AttendantTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attendantTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttendantTableTableAnnotationComposer(
              $db: $db,
              $table: $db.attendantTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TaskTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskTableTable,
    TaskTableData,
    $$TaskTableTableFilterComposer,
    $$TaskTableTableOrderingComposer,
    $$TaskTableTableAnnotationComposer,
    $$TaskTableTableCreateCompanionBuilder,
    $$TaskTableTableUpdateCompanionBuilder,
    (TaskTableData, $$TaskTableTableReferences),
    TaskTableData,
    PrefetchHooks Function({bool type, bool attendantTableRefs})> {
  $$TaskTableTableTableManager(_$AppDatabase db, $TaskTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> type = const Value.absent(),
          }) =>
              TaskTableCompanion(
            id: id,
            title: title,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int type,
          }) =>
              TaskTableCompanion.insert(
            id: id,
            title: title,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({type = false, attendantTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (attendantTableRefs) db.attendantTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (type) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.type,
                    referencedTable: $$TaskTableTableReferences._typeTable(db),
                    referencedColumn:
                        $$TaskTableTableReferences._typeTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attendantTableRefs)
                    await $_getPrefetchedData<TaskTableData, $TaskTableTable,
                            AttendantTableData>(
                        currentTable: table,
                        referencedTable: $$TaskTableTableReferences
                            ._attendantTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TaskTableTableReferences(db, table, p0)
                                .attendantTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TaskTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskTableTable,
    TaskTableData,
    $$TaskTableTableFilterComposer,
    $$TaskTableTableOrderingComposer,
    $$TaskTableTableAnnotationComposer,
    $$TaskTableTableCreateCompanionBuilder,
    $$TaskTableTableUpdateCompanionBuilder,
    (TaskTableData, $$TaskTableTableReferences),
    TaskTableData,
    PrefetchHooks Function({bool type, bool attendantTableRefs})>;
typedef $$AttendantTableTableCreateCompanionBuilder = AttendantTableCompanion
    Function({
  Value<int> id,
  required String name,
  required int taskId,
});
typedef $$AttendantTableTableUpdateCompanionBuilder = AttendantTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> taskId,
});

final class $$AttendantTableTableReferences extends BaseReferences<
    _$AppDatabase, $AttendantTableTable, AttendantTableData> {
  $$AttendantTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TaskTableTable _taskIdTable(_$AppDatabase db) =>
      db.taskTable.createAlias(
          $_aliasNameGenerator(db.attendantTable.taskId, db.taskTable.id));

  $$TaskTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<int>('task_id')!;

    final manager = $$TaskTableTableTableManager($_db, $_db.taskTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AttendantTableTableFilterComposer
    extends Composer<_$AppDatabase, $AttendantTableTable> {
  $$AttendantTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  $$TaskTableTableFilterComposer get taskId {
    final $$TaskTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTableTableFilterComposer(
              $db: $db,
              $table: $db.taskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendantTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendantTableTable> {
  $$AttendantTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  $$TaskTableTableOrderingComposer get taskId {
    final $$TaskTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTableTableOrderingComposer(
              $db: $db,
              $table: $db.taskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendantTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendantTableTable> {
  $$AttendantTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$TaskTableTableAnnotationComposer get taskId {
    final $$TaskTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskTableTableAnnotationComposer(
              $db: $db,
              $table: $db.taskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendantTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttendantTableTable,
    AttendantTableData,
    $$AttendantTableTableFilterComposer,
    $$AttendantTableTableOrderingComposer,
    $$AttendantTableTableAnnotationComposer,
    $$AttendantTableTableCreateCompanionBuilder,
    $$AttendantTableTableUpdateCompanionBuilder,
    (AttendantTableData, $$AttendantTableTableReferences),
    AttendantTableData,
    PrefetchHooks Function({bool taskId})> {
  $$AttendantTableTableTableManager(
      _$AppDatabase db, $AttendantTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendantTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendantTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendantTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> taskId = const Value.absent(),
          }) =>
              AttendantTableCompanion(
            id: id,
            name: name,
            taskId: taskId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int taskId,
          }) =>
              AttendantTableCompanion.insert(
            id: id,
            name: name,
            taskId: taskId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AttendantTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$AttendantTableTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$AttendantTableTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AttendantTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttendantTableTable,
    AttendantTableData,
    $$AttendantTableTableFilterComposer,
    $$AttendantTableTableOrderingComposer,
    $$AttendantTableTableAnnotationComposer,
    $$AttendantTableTableCreateCompanionBuilder,
    $$AttendantTableTableUpdateCompanionBuilder,
    (AttendantTableData, $$AttendantTableTableReferences),
    AttendantTableData,
    PrefetchHooks Function({bool taskId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TypeTableTableTableManager get typeTable =>
      $$TypeTableTableTableManager(_db, _db.typeTable);
  $$TaskTableTableTableManager get taskTable =>
      $$TaskTableTableTableManager(_db, _db.taskTable);
  $$AttendantTableTableTableManager get attendantTable =>
      $$AttendantTableTableTableManager(_db, _db.attendantTable);
}
