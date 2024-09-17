// listing_page.dart
import 'dart:async';
import 'package:datingapp/model/dating_profile_model.dart';
import 'package:datingapp/pages/profile_creation_page.dart';
import 'package:datingapp/pages/profile_detailed.dart';
import 'package:datingapp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datingapp/widgets/drawer_widget.dart'; // Import the new DrawerWidget class

class ListingPage extends StatefulWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  int _selectedIndex = 0;

  // Method to open the drawer
  void _openShortDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DatingColors.backgroundColor,
      // Add a Drawer widget
      drawer: DrawerWidget(
        onProfileDetailsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileDetailedPage(
                model: DatingProfileModel
                    .dummyData[0], // Replace with actual model
              ),
            ),
          );
        },
        onSettingsTap: () {
          // Handle settings
        },
        onLogoutTap: () {
          // Handle logout
        },
        oncreationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileCreationScreen()),
          );
        },
      ),
      body: Builder(
        builder: (context) => ListView(
          padding:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 70),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: Colors.blueGrey.shade700,
                  size: 28,
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Text(
                    'For you',
                    style: TextStyle(
                      color: _selectedIndex == 0
                          ? Colors.black
                          : DatingColors.lightGreyColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Text(
                    'Nearby',
                    style: TextStyle(
                      color: _selectedIndex == 1
                          ? Colors.black
                          : DatingColors.lightGreyColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    _openShortDrawer(context); // Pass context to the method
                  },
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/profiles/profile_4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (int i = 0; i < DatingProfileModel.dummyData.length; i++) ...[
              if (i != 0)
                const Divider(
                  color: Colors.black,
                  height: 3,
                ),
              const SizedBox(height: 10),
              DatingProfileWidget(
                model: DatingProfileModel.dummyData[i],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class DatingProfileWidget extends StatefulWidget {
  final DatingProfileModel model;
  const DatingProfileWidget({
    required this.model,
    super.key,
  });

  @override
  State<DatingProfileWidget> createState() => _DatingProfileWidgetState();
}

class _DatingProfileWidgetState extends State<DatingProfileWidget> {
  int _currentMatchPercentage = 0;
  Timer? _timer; // Add a Timer variable to manage the timer

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 6), (timer) {
      if (_currentMatchPercentage < widget.model.matchPercentage) {
        if (mounted) {
          // Check if the widget is still mounted
          setState(() {
            _currentMatchPercentage++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailedPage(
              model: widget.model,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 270,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.model.assetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.model.name}, ${widget.model.age}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (widget.model.name == 'Linda' ||
                            widget.model.isOnline)
                          const SizedBox(width: 9),
                        if (widget.model.name == 'Linda' ||
                            widget.model.isOnline)
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: DatingColors.lightGreenColor,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      widget.model.location,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 38,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$_currentMatchPercentage% match',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
