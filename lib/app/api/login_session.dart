import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginSession extends GetxService {
  static final _otherBox = () => GetStorage('LoginPref');
  final rkm = ''.val('no_rkm_medis');
  final nama = ''.val('nm_pasien');
  final nip = ''.val('nip');
  final jk = ''.val('jk');
  final tmpLahir = ''.val('tmp_lahir');
  final email = ''.val('email');
  final telp = ''.val('no_telp');
  final noPeserta = ''.val('no_peserta');
  final password = ''.val('password');
  final token = ''.val('token');
}
