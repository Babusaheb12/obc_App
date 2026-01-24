import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:obc_app/utils/flutter_color_themes.dart';
import '../../utils/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final int accountBadgeCount;
  final int messageBadgeCount;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.accountBadgeCount = 0,
    this.messageBadgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    double horizontalPadding = 0;
    double bottomPadding = 0;

    if (kIsWeb) {
      horizontalPadding = screenWidth * 0.3;
    }

    Widget _iconWithBadge(IconData icon, int count) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon),
          if (count > 0)
            Positioned(
              right: -6,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    final navBar = BottomNavigationBar(
      backgroundColor: AppColors.white,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: _iconWithBadge(Icons.person, accountBadgeCount),
          label: Constants.spares,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: Constants.accessories,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.sell),
          label: Constants.tyreAlloys,
        ),
        BottomNavigationBarItem(
          icon: _iconWithBadge(Icons.message, messageBadgeCount),
          label: Constants.preowned,
        ),

      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.white,  /// change the color
      unselectedItemColor: AppColors.black,  //// change the color
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 12.03,
        height: 22.39 / 11.03,
        letterSpacing: 0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        fontSize: 12.03,
      ),
    );

    // ✅ Wrap navBar in Container for web with background color
    return kIsWeb
        ? Container(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 8),
      color: Colors.white,
      child: navBar,
    )
        : Container(
      color: Colors.white, // ✅ Background color for mobile/tablet
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          0,
          horizontalPadding,
          bottomPadding,
        ),
        child: navBar,
      ),
    );
  }


}
// *********************************** class 2 ****************************************








// Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
//   final isSelected = selectedIndex == index;
//
//   return GestureDetector(
//     onTap: () => onItemTapped(index),
//     behavior: HitTestBehavior.translucent, // Makes even empty area tappable
//     child: Container(
//       width: 110, // 👈 Increases horizontal tap area (adjust as needed)
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 26, // Slightly larger icon
//             color: isSelected ? AppColors.selectedNavBar : AppColors.bottomNavBar,
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: isSelected ? AppColors.selectedNavBar : AppColors.bottomNavBar,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }




// }



