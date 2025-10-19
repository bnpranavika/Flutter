import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Your existing imports
import 'Flutter_Widgets.dart'; // MyTextWidget
import 'Navigators.dart'; // HomeScreen, SecondScreen
import 'Media_Queries_&_breakpoints.dart'; // Responsive layouts
import 'Navigation_With_Namedroutes.dart'; // HomePage, AboutPage, ContactPage
import 'Responsive_UI.dart'; // Responsive UI demo
import 'Setstate_&_Provider.dart'; // For Provider demo
import 'Statefull_Widgets.dart'; // Stateful demo
import 'Stateless_Widgets.dart'; // Stateless demo
import 'UI_Elements.dart'; // UIElementsTab
import 'Themes.dart'; // ThemeDemoScreen
import 'Form_Validation.dart'; // FormDemoScreen
import 'Animated_UI.dart'; // AnimatedUITab
import 'Animated_Types.dart'; // AnimatedTypesTab
import 'API_Fetched.dart'; // ✅ Updated API Fetch tab

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalCounter(),
      child: const MyApp(),
    ),
  );
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
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
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
      length: 14, // ✅ Updated to match the 14 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Multi-Tab Demo"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Widget Tab"),
              Tab(text: "Navigation Tab"),
              Tab(text: "Breakpoints Tab"),
              Tab(text: "Responsive UI Tab"),
              Tab(text: "Named Routes Tab"),
              Tab(text: "SetState & Provider"),
              Tab(text: "Stateful Widgets"),
              Tab(text: "Stateless Widgets"),
              Tab(text: "UI Elements"),
              Tab(text: "Themes"),
              Tab(text: "Form"),
              Tab(text: "Animations"),
              Tab(text: "Animations 2"),
              Tab(text: "API Fetch"), // 14th tab
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyTextWidget(),
            NavigationTab(),
            ResponsiveWrapper(),
            ResponsiveHome(),
            NamedRoutesWrapper(),
            CombinedCounterScreen(),
            MyStatefulWidget(),
            MyStatelessWidget(),
            UIElementsTab(),
            ThemeDemoScreen(),
            FormDemoScreen(),
            AnimatedUITab(),
            AnimatedTypesTab(),
            ApiFetchTab(), // 14th tab content
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

/// Tab 3: Responsive layouts (breakpoints)
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

/// Tab 5: Named routes demo
class NamedRoutesWrapper extends StatelessWidget {
  const NamedRoutesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageTab();
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

/// About Page
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

/// Contact Page
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
