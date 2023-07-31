import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/core/constant/var_constant.dart';
import 'package:vpn_basic_project/core/models/vpn.dart';

class Repository {
  static Future<void> getVpnData() async {
    print('Start Call Api ~~~>>> ${DateTime.now()}');
    final response = await get(Uri.parse('http://www.vpngate.net/api/iphone/'));
    print('Api Called ~~~>>> ${DateTime.now()}');
    if (response.statusCode == 200) {
      print('Translate Data ~~~>>> ${DateTime.now()}');
      final csvString = response.body.split("#")[1].replaceAll('*', '');
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
      final header = list[0];
      for (int i = 1; i < list.length - 1; i++) {
        Map<String, dynamic> tempJson = {};
        for (int j = 0; j < header.length; j++) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        VarConstant.vpnList.add(Vpn.fromJson(tempJson));
      }
      print('Data Translated ~~~>>> ${DateTime.now()}');
    }
    return null;
  }
}
