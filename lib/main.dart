// ignore_for_file: unused_element, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:Salam_islam/screens/secret_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info/package_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp() as Widget);
}

class MyApp {
}

class RamazanApp extends StatefulWidget {
  const RamazanApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RamazanAppState createState() => _RamazanAppState();
}

class _RamazanAppState extends State<RamazanApp> {
  List<dynamic> timings = [];
  Timer? _timer;
  DateTime currentDate = DateTime.now();
  int _tapCounter = 0;
  final TextEditingController _adminPasswordController = TextEditingController();
  // ignore: unused_field
  PackageInfo? _packageInfo;
  
  get _buildVersionText => null;
  
  get buildPrayerTimeCard2 => null;

  @override
  void initState() {
    super.initState();
    loadTimings();
    _initPackageInfo();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => currentDate = DateTime.now());
    });
  }

  Future<void> loadTimings() async {
    final String response = await rootBundle.loadString('assets/timings.json');
    final data = json.decode(response);
    setState(() => timings = data["ramazan"]);
  }

  String _formatTimeDifference(String targetTime) {
    final format = DateFormat('h:mm a');
    final now = currentDate;
    final target = format.parse(targetTime);
    final targetDateTime = DateTime(now.year, now.month, now.day, target.hour, target.minute);
    
    if (targetDateTime.isAfter(now)) {
      final difference = targetDateTime.difference(now);
      return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    }
    return 'Time passed';
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  void _showAdminLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ادخل الرمز السري', textAlign: TextAlign.center),
        content: TextField(
          obscureText: true,
          controller: _adminPasswordController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () async {
                final doc = await FirebaseFirestore.instance
                    .collection('settings')
                    .doc('admin_password')
                    .get();
                
                if (doc.exists && doc['password'] == _adminPasswordController.text) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => const SecretSettingsPage()),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('كلمة المرور غير صحيحة'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('تأكيد', style: TextStyle(fontSize: 18)),
          ),
          ),
        ],
      );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var buildVersionText2 = _buildVersionText;
    var buildVersionText = buildVersionText2;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      home: Scaffold(
        body: GestureDetector(
          onTapDown: (details) {
            _tapCounter++;
            if (_tapCounter == 5) {
              _showAdminLogin(context);
              _tapCounter = 0;
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(),
                    _buildTimingsList(),
                    _buildFooter(),
                  ],
                ),
                buildVersionText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF2A5934),
      colorScheme: const ColorScheme.light(secondary: Color(0xFFF0B548)),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        headlineMedium: const TextStyle(
          fontSize: 22, 
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    var buildPrayerTimeCard = buildPrayerTimeCard2;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.location_on, color: Colors.white70),
              Text("مكة المكرمة", style: Theme.of(context).textTheme.headlineMedium),
              const Icon(Icons.settings, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            DateFormat('EEEE, d MMMM').format(currentDate),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          buildPrayerTimeCard,
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildPrayerTimeCard(dynamic PrayerTimeTile) {
    var classID = ClassID();
    var prayerTimeTile = PrayerTimeTile;
    var prayerTimeTile2 = PrayerTimeTile;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          prayerTimeTile2(
            title: "نهاية السحور",
            time: timings.isNotEmpty ? timings[0]['sehri'] : "--:--",
          ),
          const VerticalDivider(color: Colors.white54),
         prayerTimeTile(
            title: "بدء الإفطار",
            time: timings.isNotEmpty ? timings[0]['iftar'] : "--:--",
          ),
        ],
      ),
    );
  }

  Widget _buildTimingsList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: timings.length,
        itemBuilder: (context, index) {
          final dayTiming = timings[index];
          final isToday = index == 0;
          return _buildTimingCard(dayTiming, isToday);
        },
      ),
    );
  }

  Widget _buildTimingCard(Map<String, dynamic> dayTiming, bool isToday) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isToday ? Theme.of(context).colorScheme.secondary : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: _buildDayCircle(dayTiming['day'].toString(), isToday),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTimeColumn("السحور", dayTiming['sehri'], isToday),
            _buildTimeColumn("الإفطار", dayTiming['iftar'], isToday),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCircle(String day, bool isToday) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isToday ? Colors.white : Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isToday ? Theme.of(context).primaryColor : Colors.white,
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String title, String time, bool isToday) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isToday ? Colors.white : Colors.black,
          ),
        ),
        Text(
          _formatTimeDifference(time),
          style: TextStyle(
            fontSize: 12,
            color: isToday ? Colors.white70 : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "رمضان كريم",
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Lateef',
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }