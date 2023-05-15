import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'firebase_options.dart';
import 'screen/screen1.dart';
import 'screen/screen2.dart';
import 'screen/screen3.dart';
import 'screen/screen4.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    Screen1(link: "",),
    Screen2(link: ""),
    Screen3(link: ""),
    Screen4(link: ""),
  ];

  final List<String> _icon = [
    'assets/icons/house-solid.svg',
    'assets/icons/right-to-bracket-solid.svg',
    'assets/icons/right-from-bracket-solid.svg',
    'assets/icons/circle-info-solid.svg',
  ];
  void init() async {}

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pop(context);
  }

  final List<String> _title = ['Trang chủ', 'Đăng nhập', 'Đăng ký', 'Hỗ trợ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          // backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            _title[_selectedIndex],
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          elevation: 0,
        ),
        // backgroundColor: backgroundColor,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 112,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                    ),
                    child: Row(
                      children: const [],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(
                      4, (index) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        _icon[index],
                        color: index == _selectedIndex
                            ? Colors.blue
                            : Colors.grey,
                        width: 23,
                      ),
                      title: Text(
                        _title[index],
                        // style: TextStyle(color: Colors.white),
                        style: index != _selectedIndex
                            ? const TextStyle(
                            height: 0, fontSize: 14, color: Colors.grey)
                            : const TextStyle(
                            height: 0, fontSize: 14, color: Colors.blue),
                      ),
                      selected: _selectedIndex == index,
                      onTap: () async {
                        _onItemTapped(index);
                        // }
                      },
                    );
                  }
                  ),
                ),
              )
            ],
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
