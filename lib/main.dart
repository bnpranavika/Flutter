import 'package:flutter/material.dart';
import 'Flutter_Widgets.dart'; // MyTextWidget
import 'Navigators.dart'; // HomeScreen, SecondScreen
import 'Media_Queries_&_breakpoints.dart'; // Responsive layouts
import 'Navigation_With_Namedroutes.dart'; // HomePage, AboutPage, ContactPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Multi-Tab Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabDemoPage(),
    );
  }
}

class TabDemoPage extends StatelessWidget {
  const TabDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // 4 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Multi-Tab Demo"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Widget Tab"),
              Tab(text: "Navigation Tab"),
              Tab(text: "Responsive Tab"),
              Tab(text: "Named Routes Tab"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyTextWidget(), // Tab 1: Flutter_Widgets.dart
            NavigationTab(), // Tab 2: Navigators.dart
            ResponsiveWrapper(), // Tab 3: Media_Queries_&_breakpoints.dart
            NamedRoutesWrapper(), // Tab 4: Navigation_With_Namedroutes.dart
          ],
        ),
      ),
    );
  }
}

/// Tab 2: Navigation button demo
class NavigationTab extends StatelessWidget {
  const NavigationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondScreen()),
          );
        },
        child: const Text("Go to Second Screen"),
      ),
    );
  }
}

/// Tab 3: Responsive layouts
class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return const MobileLayout();
    } else if (screenWidth >= 600 && screenWidth < 1024) {
      return const TabletLayout();
    } else {
      return const DesktopLayout();
    }
  }
}

/// Tab 4: Named routes demo
class NamedRoutesWrapper extends StatelessWidget {
  const NamedRoutesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageTab(); // Use a wrapper to show your HomePage inside the tab
  }
}

/// Wrapper for HomePage from Navigation_With_Namedroutes.dart
class HomePageTab extends StatelessWidget {
  const HomePageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🏠 Home")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPageTab()),
              );
            },
            child: const Text("Go to About Page"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPageTab()),
              );
            },
            child: const Text("Go to Contact Page"),
          ),
        ],
      ),
    );
  }
}

/// About Page for tab
class AboutPageTab extends StatelessWidget {
  const AboutPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ℹ️ About")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back to Home"),
        ),
      ),
    );
  }
}

/// Contact Page for tab
class ContactPageTab extends StatelessWidget {
  const ContactPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📞 Contact")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back to Home"),
        ),
      ),
    );
  }
}
