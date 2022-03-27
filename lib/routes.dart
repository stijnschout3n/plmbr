import 'package:plmbr/about/about.dart';
import 'package:plmbr/apps/apps.dart';
import 'package:plmbr/crm/AddCustomer.dart';
import 'package:plmbr/crm/crm.dart';
import 'package:plmbr/home/home.dart';
import 'package:plmbr/landing/landing.dart';
import 'package:plmbr/login/login.dart';
import 'package:plmbr/profile/profile.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/apps': (context) => const AppsScreen(),
  '/landing': (context) => const LandingScreen(),
  '/crm': (context) => const CrmScreen(),
  '/crm/addCustomer': (context) => AddCustomerScreen(),
};
