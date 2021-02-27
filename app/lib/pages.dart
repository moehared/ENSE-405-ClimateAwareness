import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/community_screen.dart';
import 'screens/forum_screen.dart';
import 'screens/location_screen.dart';
import 'screens/profile_screen.dart';

List<Map<String, Object>> pages = [
  {
    'page': CommunityScreen(),
    'title': 'Community',
    'action': IconButton(
      icon: Icon(
        Icons.add,
      ),
      onPressed: () {},
    ),
  },
  {
    'page': ChatScreen(),
    'title': 'Chat',
    'action': IconButton(
      icon: Icon(
        Icons.notifications,
      ),
      onPressed: () {},
    ),
  },
  {
    'page': LocationScreen(),
    'title': 'Location',
    'action': IconButton(
      icon: Icon(
        Icons.search,
      ),
      onPressed: () {},
    ),
  },
  {
    'page': ForumScreen(),
    'title': 'Forum',
    'action': IconButton(
      icon: Icon(
        Icons.search,
      ),
      onPressed: () {},
    ),
  },
  {
    'page': ProfileScreen(),
    'title': 'Profile',
    'action': IconButton(
      icon: Icon(
        Icons.more_vert_rounded,
      ),
      onPressed: () {},
    ),
  },
];
