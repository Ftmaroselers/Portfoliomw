import 'package:flutter/material.dart';

import 'widgets/navigation_bar.dart';
import 'widgets/home_content.dart';
import 'widgets/project_content.dart';
import 'widgets/contact_content.dart';
import 'widgets/footer.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',

      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF070707),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF50131F),
          secondary: Color(0xFF070707),
        ),
      ),

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.75, -0.4),
            radius: 1.2,
            colors: [Color(0xFF50131F), Color(0xFF21090F), Color(0xFF070707)],
            stops: [0.0, 0.45, 1.0],
          ),
        ),

        child: Column(
          children: [
            PortfolioNavigationBar(
              currentIndex: currentIndex,

              onItemSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),

            Expanded(child: _buildPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (currentIndex) {
      case 0:
        return const HomeContent();

      case 1:
        return const ProjectContent();

      case 2:
        return const ContactContent();

      default:
        return const HomeContent();
    }
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [HomeContent(), PortfolioFooter()]),
    );
  }
}
