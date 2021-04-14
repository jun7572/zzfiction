import 'package:moor/moor.dart';

class Dogs extends Table{
  TextColumn get name=> text().nullable()();
  TextColumn get color=> text().nullable()();

  IntColumn get id => integer().nullable().autoIncrement()();

  //各种写法

  // // 可空类型
  // IntColumn get completeDate => integer().nullable()();
  // TextColumn get completeDateStr => text().nullable()();
  // TextColumn get content => text().nullable()();
  //
  // // 为空自动生成默认值
  // IntColumn get date =>
  //     integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  //
  // // 为空自动生成默认值
  // TextColumn get dateStr =>
  //     text().nullable().clientDefault(() => DateTime.now().format())();
  //
  // // 主键
  // IntColumn get id => integer().nullable().autoIncrement()();
  //
  // // 为空自动生成默认值
  // IntColumn get priority => integer().nullable().withDefault(Constant(0))();
  //
  // // 为空自动生成默认值
  // IntColumn get status => integer().nullable().withDefault(Constant(0))();
  //
  // TextColumn get title => text()();
  //
  // IntColumn get type => integer().withDefault(Constant(0))();
  //
  // IntColumn get userId => integer().nullable()();

}
@useMoor(tables: [Dogs])
class DogsDatabase extends _$DogsDatabase{
  // we tell the database where to store the data with this constructor
  DogsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}