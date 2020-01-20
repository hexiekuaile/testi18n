# testi18n

一个Flutter StatelessWidget国际化简单示例，字符串来自于json文件.
在学习flutter国际化过程中，走了一些弯路，所以共享了这小项目。
关键还是谁来调用、调用什么、调用顺序。
代码在i18n.dart、main.dart中，代码有详细说明。

除此之外，还想实现个目标，即supportedLocales属性赋值通过json文件获得，但目前不知道从哪调用来实现，如有同学能实现，请告知，fy126126@qq.com
## 开始
- 一、使用flutter create testi18n 创建一个flutter项目
- 二、在项目根目录下新建i18n目录，在i18n目录下新建zh_CN.json、en_US.json,里面内容分别如下
    - zh_CN.json：{"pushedTimes": "按键次数{0}xxx{1}"}
    - en_US.json： {"pushedTimes": "You have pushed the button this many times:  {0}xxx{1}"}
- 三、在pubspec.yaml中dependencies:项下增加
      flutter_localizations:
        sdk: flutter
        在flutter:项下增加
        assets:
          - ./i18n/
- 四、在lib目录下新建i18n.dart，里面有两个类Strings、I18nDelegate。
- 五、修改main.dart，MaterialApp的supportedLocales属性、localizationsDelegates属性,一个Text显示值,
- 六、用法：支持简单查找、支持用字符串替换 {0} {1}等等，序号从0开始;支持用Map value替换::Map key::，例子： "pushedTimes": "按键次数{0}xxx{1}"
        
    Strings.of(context).valueOf("key") //To get a simple string
    Strings.of(context).valueOf("key", args: ["A", "B", "C"]) //To get a interpoled string
    Strings.of(context).pluralOf("key", 0) //To get a plural string
    Strings.of(context).pluralOf("key", 0, args: ["A", "B", "C"]) //To get a plural interpoled string
    Strings.of(context).valueOf("key", args: ["A", "B", "C"], namedArgs: {"named_arg_key": "Named arg"}) //To get a interpoled name string
    
- json文件格式示例：
{
    "simple_string": "Simple string value",
    "interpolation_string": "Interpoleted {0} string {1}",
    "simple_plurals" : {
        "zero": "No information",
        "one": "A item",
        "other": "Many itens"
    },
    "interpolation_plurals": {
        "zero": "No information {0} with {1}",
        "one": "A item {0} with {1}",
        "other": "Many itens {0} with {1}"
    },
    "interpolation_string_with_named_args": "Interpoleted {0} string with ::named_arg_key::"
}


This project is a starting point for a Flutter application.

在学习过程中参考了如下文章:

- [internationalization 2.0.0](https://pub.dev/packages/internationalization)
- [Flutter~国际化教程方案](http://zhoushaoting.com/2019/06/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%9B%BD%E9%99%85%E5%8C%96%E6%95%99%E7%A8%8B%E6%96%B9%E6%A1%88/)