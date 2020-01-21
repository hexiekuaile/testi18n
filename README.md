# testi18n

一个Flutter StatelessWidget国际化简单示例，字符串来自于json文件.
在学习flutter国际化过程中，走了一些弯路，所以共享了这小项目。
关键还是谁来调用、调用什么、调用顺序。
代码在i18n.dart、main.dart中，代码有详细说明。

除此之外，还想实现个目标，即supportedLocales属性赋值通过json文件获得，但目前不知道从哪调用来实现，如有同学能实现，请告知，fy126126@qq.com
## 开始
- 一、使用flutter create testi18n 创建一个flutter项目
- 二、在项目根目录下新建i18n目录，在i18n目录下新建zh_CN.json、en_US.json,里面内容分别如下
    - zh_CN.json：
    ```
    {
        "pushedTimes": "按键次数{0}xxx{1}"
    }
    ```
    - en_US.json： 
    ```
    {
        "pushedTimes": "You have pushed the button this many times:  {0}xxx{1}"
    }
    ```
- 三、在pubspec.yaml中dependencies:项下增加
```
      flutter_localizations:
        sdk: flutter
```
在flutter:项下增加
```
        assets:
          - ./i18n/
```
- 四、在lib目录下新建i18n.dart，里面有两个类Strings、I18nDelegate。
- 五、修改main.dart，MaterialApp的supportedLocales属性、localizationsDelegates属性,Text显示值,
- 六、整个的调用过程如下：
    1. 把i18nDelegate国际化策略变量注册到MaterialApp的localizationsDelegates属性中。
    2. flutter 回调 I18nDelegate 类的load方法，取得异步的国际化字符串类实例 Future < Strings > 。
    3. Text widget 的显示值 通过国际化字符串类实例 Strings 获得。Strings.of(context).valueOf('pushedTimes')

- 七、用法：支持简单查找、支持用字符串替换 {0} {1}等等，序号从0开始;支持用Map value替换::Map key::，例子： "pushedTimes": "按键次数{0}xxx{1}"
   ```     
    Strings.of(context).valueOf("key") //To get a simple string
    
    Strings.of(context).valueOf("key", args: ["A", "B", "C"]) //To get a interpoled string
    
    Strings.of(context).pluralOf("key", 0) //To get a plural string
    
    Strings.of(context).pluralOf("key", 0, args: ["A", "B", "C"]) //To get a plural interpoled string
    
    Strings.of(context).valueOf("key", args: ["A", "B", "C"], namedArgs: {"named_arg_key": "Named arg"}) //To get a interpoled name string
    ```
    
- 八、json文件格式示例：
```
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
```
- 九、在main.dart中的注释如下：

    1. localeListResolutionCallback回调参数locales对应安卓手机语言设置列表，而且有优先级顺序，第0个是默认语言；
    2. localeListResolutionCallback回调参数supportedLocales即是MaterialApp的supportedLocales属性，没有优先级顺序，
     另外当这个列表项只有一个子项时，则只显示这个子项。比如只有 Locale('zh', 'CN')项时，只显示中文。
    3. localeListResolutionCallback回调不是必须的，关键还是supportedLocales属性、安卓手机语言设置列表。
    4. 当开发flutter web版时，想显示中文，可以通过两种方式，一个是supportedLocales列表只有一个中文项，另一个是设定回调返回值为中文。
    5. 若要实现手动更改UI语言文字，首先要MyApp extends StatefulWidget，二要`i18nDelegate=new I18nDelegate(Locale('xx', 'xx'))、setState`。

在学习过程中参考了如下文章:

- [internationalization 2.0.0](https://pub.dev/packages/internationalization)
- [Flutter~国际化教程方案](http://zhoushaoting.com/2019/06/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%9B%BD%E9%99%85%E5%8C%96%E6%95%99%E7%A8%8B%E6%96%B9%E6%A1%88/)
