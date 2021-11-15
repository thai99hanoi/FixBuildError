import 'package:flutter/material.dart';

class NavigationUtil {
   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

   static void push(MaterialPageRoute route){
     navigatorKey.currentState!.push(route);
   }

   static void pushReplacement(MaterialPageRoute route){
     navigatorKey.currentState!.pushReplacement(route);
   }

   static void pushReplacementNamed(String routeName){
     navigatorKey.currentState!.pushReplacementNamed(routeName);
   }

  static void pushNamed(String routeName){
     navigatorKey.currentState!.pushNamed(routeName);
   }

  static void pop(){
     navigatorKey.currentState!.pop();
   }
}