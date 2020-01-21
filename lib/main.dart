import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // 界面初始化时候，传进null，默认显示安卓界面首选语言
  LocalizationsDelegate i18nDelegate = new I18nDelegate(null);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      supportedLocales: [
        Locale('zh', 'CN'),
        // Locale('en', 'US')
      ],
      /*
     1、localeListResolutionCallback回调参数locales对应安卓手机语言设置列表，而且有优先级顺序，第0个是默认语言；
     2、localeListResolutionCallback回调参数supportedLocales即是MaterialApp的supportedLocales属性，没有优先级顺序，
     另外当这个列表项只有一个子项时，则只显示这个子项。比如只有 Locale('zh', 'CN')项时，只显示中文。
     3、localeListResolutionCallback回调不是必须的，关键还是supportedLocales属性、安卓手机语言设置列表。
     4、当开发flutter web版时，想显示中文，可以通过两种方式，一个是supportedLocales列表只有一个中文项，另一个是设定回调返回值为中文。
     5、若要实现手动更改UI语言文字，首先要MyApp extends StatefulWidget，二要new I18nDelegate(Locale('xx', 'xx'))、setState。

      localeListResolutionCallback: (List<Locale> locales, Iterable<Locale> supportedLocales) {
       
        //return locales[0];
       //return Locale('zh', 'CN');
       return null;
      },*/
      localizationsDelegates: [
        //修改这个变量、setState，可以更改UI语言文字
        i18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text('You have pushed the button this many times:'),
            // Text(Strings.of(context).valueOf('pushedTimes')),
            Text(Strings.of(context)
                .valueOf('pushedTimes', args: ['aaa', 'bbb'])),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
