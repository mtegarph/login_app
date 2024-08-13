import 'package:hive/hive.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';
part 'register_hive.g.dart';

@HiveType(typeId: 0)
class RegisterHive extends HiveObject {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? noHp;
  @HiveField(4)
  String? id;
  RegisterHive({this.email, this.password, this.name, this.noHp, this.id});
  factory RegisterHive.fromObatEntity(RegisterEntity registerEntity) {
    return RegisterHive(
        id: registerEntity.id,
        email: registerEntity.email,
        password: registerEntity.password,
        name: registerEntity.name,
        noHp: registerEntity.noHp);
  }
}
