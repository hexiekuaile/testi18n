import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Strings {
  //约定：国际化字符串必须放在这个目录下
  static const String _dir = './i18n/';
  Locale _loc;
  Map<String, dynamic> _map;

  Strings(Locale loc) {
    print("******* Strings()");
    this._loc = loc;
  }

  //国际化json文件目录
  String get dir => _dir;
  //区域
  Locale get locale => _loc;
  //国际化字符串map
  Map<String, dynamic> get map => _map;

  //获取context中的Strings
  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

//获取国际化字符串类
  static Future<Strings> load(Locale loc) async {
    print("........load() async .......");
    print(loc);
    Strings strings = new Strings(loc);

    String p;
    if (loc?.countryCode?.isEmpty == true)
      p = '$_dir${loc.languageCode}.json';
    else
      p = '$_dir${loc.languageCode}_${loc.countryCode}.json';

    String data = await rootBundle.loadString(p);
    strings._map = json.decode(data);
    print(strings._map);
    return strings;
  }

  String valueOf(String key, {List<String> args, Map<String, dynamic> namedArgs}) {
    //如果json文件不存在key，则返回key
    if (!_map.containsKey(key)) return key;

    String value = _map[key].toString();
    //支持字符串替换
    value = _interpolateValue(value, args, namedArgs);
    return value;
  }

  String pluralOf(String key, int pluralValue, {List<String> args, Map<String, dynamic> namedArgs}) {
    if (!_map.containsKey(key)) return key;

    Map<String, dynamic> plurals = _map[key];
    final plural = {
          0: "zero",
          1: "one"
        }[pluralValue] ??
        "other";
    String value = plurals[plural].toString();
    value = _interpolateValue(value, args, namedArgs);

    return value;
  }

  //支持用字符串替换 {0} {1}等等，序号从0开始;支持用Map value替换::Map key::
  //例子： "pushedTimes": "按键次数{0}xxx{1}"
  String _interpolateValue(String value, List<String> args, Map<String, dynamic> namedArgs) {
    for (int i = 0; i < (args?.length ?? 0); i++) {
      value = value.replaceAll("{$i}", args[i]);
    }

    if (namedArgs?.isNotEmpty == true) {
      namedArgs.forEach((entryKey, entryValue) => value = value.replaceAll("::$entryKey::", entryValue.toString()));
    }

    return value;
  }
}

class I18nDelegate extends LocalizationsDelegate<Strings> {
  Locale _loc;

  I18nDelegate(this._loc);

  set loc(Locale value) {
    _loc = value;
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<Strings> load(Locale locale) async {
    print("&&&&&&&& Future<Strings> load(Locale locale) async ");
    //app启动时：构造器传进来的_loc==null,locale为安卓机器首选语言
    //手动更改语言时：构造器传进来的_loc !=null
    _loc = _loc ?? locale;
    return Strings.load(_loc);
  }

  @override
  bool shouldReload(I18nDelegate old) => false;
}
