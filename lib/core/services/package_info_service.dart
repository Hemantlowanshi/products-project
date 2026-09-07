import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  final PackageInfo _packageInfo;

  PackageInfoService(this._packageInfo);

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
}
