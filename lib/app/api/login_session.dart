import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginSession extends GetxService {
  static final _otherBox = () => GetStorage('Login');
  final rkm = ''.val('no_rkm_medis', getBox: _otherBox);
  final nama = ''.val('nm_pasien', getBox: _otherBox);
  final nip = ''.val('nip', getBox: _otherBox);
  final jk = ''.val('jk', getBox: _otherBox);
  final tmpLahir = ''.val('tmp_lahir', getBox: _otherBox);
  final email = ''.val('email', getBox: _otherBox);
  final telp = ''.val('no_telp', getBox: _otherBox);
  final noPeserta = ''.val('no_peserta', getBox: _otherBox);
  final password = ''.val('password', getBox: _otherBox);
  final token = ''.val('token', getBox: _otherBox);
}
