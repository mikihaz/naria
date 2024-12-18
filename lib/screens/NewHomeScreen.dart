import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nari/bases/Appthemes.dart';
import 'package:nari/screens/NewsdetailScreen.dart';
import 'package:nari/screens/SOSScreen.dart';
import 'package:nari/screens/components/NewsListPage.dart';
import 'package:nari/screens/components/TopSectionWidget.dart';
import 'package:nari/screens/components/news_card.dart';

class NewHomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const NewHomeScreen({super.key, required this.cameras});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final List<String> categories = [
    'Technology',
    'Sports',
    'Health',
    'Business',
    'Entertainment',
    'Science',
    'World',
  ];

  final List<String> carouselImages = [
    'assets/images/britania.webp',
    'assets/images/britania.webp',
    'assets/images/britania.webp',
  ];
  // Variables for floating button position
  double xPos = 20.0;
  double yPos = 600.0;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    // Get device screen size for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300], // Subtle background color
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content below the fixed header
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Fill width
                  children: [
                    const SizedBox(height: 10),

                    // Carousel slider with rounded corners
                    CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.20,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: carouselImages.map((imagePath) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: screenWidth,
                          ),
                        );
                      }).toList(),
                    ),

                    // Categories title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),

                    // Horizontally scrollable category container
                    SizedBox(
                      height: 60, // Responsive height for categories
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(categories.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: index == 0
                                    ? 16
                                    : 5, // Add 16 margin to the first item
                                right: index == categories.length - 1
                                    ? 16
                                    : 5, // Add 16 margin to the last item
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // News card widget
                    NewsListPage()
                  ],
                ),
              ),
            ),

            // Fixed TopSectionWidget
            const TopSectionWidget(),
            // Draggable Floating SOS Button
            Positioned(
              left: xPos,
              top: yPos,
              child: GestureDetector(
                onPanStart: (_) {
                  setState(() {
                    isDragging = true;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    xPos += details.delta.dx;
                    yPos += details.delta.dy;
                  });
                },
                onPanEnd: (_) {
                  setState(() {
                    isDragging = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SOSScreen(
                              widget.cameras), // Pass available cameras
                        ),
                      );
                    },
                    child: const Icon(Icons.warning_rounded,
                        color: AppThemes.background),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
