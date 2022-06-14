import 'package:flutter/material.dart';
import 'package:plmbr/about/about.dart';
import 'package:plmbr/admin/admin.dart';
import 'package:plmbr/apps/apps.dart';
import 'package:plmbr/crm/AddCustomer.dart';
import 'package:plmbr/crm/crm.dart';
import 'package:plmbr/home/home.dart';
import 'package:plmbr/knowledge-base/knowledge-base.dart';
import 'package:plmbr/landing/landing.dart';
import 'package:plmbr/login/login.dart';
import 'package:plmbr/profile/profile.dart';
import 'calendar/calendar.dart';
import 'dashboard/dashboard.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/about': (context) => const AboutScreen(),
  '/apps': (context) => const AppsScreen(),
  '/landing': (context) => const LandingScreen(),
  '/crm': (context) => const CrmScreen(),
  '/crm/addCustomer': (context) => AddCustomerScreen(),
  '/calendar': (context) => const CalendarScreen(),
  '/knowledgebase': (context) => const KBScreen(),
  '/administration': (context) => const AdminScreen(),
  '/dashboard': (context) => const DashboardScreen(),
};
