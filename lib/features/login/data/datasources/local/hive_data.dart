import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_app/features/login/data/models/local/register_hive.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';

class HiveData {
  Box<RegisterHive> registerHive = Hive.box<RegisterHive>('register_hive');

  Future<void> addData(RegisterEntity addRegister) async {
    try {
      final items = registerHive.values
          .where((element) => element.id == addRegister.id)
          .firstOrNull;
      if (items == null) {
        await registerHive.clear();

        await registerHive.add(RegisterHive.fromObatEntity(addRegister));
        print('berhasil');
      } else {
        print('berhasil update');
        await registerHive.put(
            items.key, RegisterHive.fromObatEntity(addRegister));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  RegisterHive? getFirstData() {
    try {
      if (registerHive.isNotEmpty) {
        return registerHive.values.first;
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
