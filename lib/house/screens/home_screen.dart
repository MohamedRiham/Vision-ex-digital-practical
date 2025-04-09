import 'package:flutter/material.dart';
import 'package:vision_ex_digital_practical/house/screens/general_house_details_screen.dart';
import 'package:vision_ex_digital_practical/house/screens/popular_house_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {}); // to update BottomNavigationBar current index
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [GeneralHouseDetailsScreen(), PopularHouseDetailsScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) {
          _tabController.animateTo(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'General'),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Popular'),
        ],
      ),
    );
  }
}
