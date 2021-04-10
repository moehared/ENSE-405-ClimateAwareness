import 'screens/community_screen.dart';
import 'screens/profile_screen.dart';

List<Map<String, Object>> pages = [
  {
    'page': CommunityScreen(),
  },
  // {
  //   'page': ChatScreen(),
  // },
  // {
  //   'page': LocationScreen(),
  // },
  // {
  //   'page': ForumScreen(),
  // },
  {
    'page': ProfileScreen(),
  },
];

final dropDownList = ['select article type', 'article', 'media'];
