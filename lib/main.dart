import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuvouchervn/remote_config_service.dart';

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

  final firebaseRemoteConfigService = const FirebaseRemoteConfigService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseRemoteConfig>(
        future: firebaseRemoteConfigService.setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? MyHomePage(remoteConfig: snapshot.data)
              : const Scaffold(
                body: Center(child: CircularProgressIndicator(),),
          );
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.remoteConfig});

  final FirebaseRemoteConfig remoteConfig;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  late List<String> weblinks;

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
    weblinks = [
      widget.remoteConfig.getString('weblink1'),
      widget.remoteConfig.getString('weblink2'),
      widget.remoteConfig.getString('weblink3'),
      widget.remoteConfig.getString('weblink4'),
    ];
  }

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
        body: [
          Screen1(link: weblinks[0]),
          Screen2(link: weblinks[1]),
          Screen3(link: weblinks[2]),
          Screen4(link: weblinks[3]),
        ].elementAt(_selectedIndex));
  }
}

