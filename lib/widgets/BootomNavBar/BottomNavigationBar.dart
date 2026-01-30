import 'package:flutter/material.dart';
import '../../utils/flutter_color_themes.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildBarItem(Icons.home_filled, "Home", 0),
          _buildBarItem(Icons.settings_outlined, "Spares", 1),
          _buildBarItem(Icons.minor_crash_outlined, "Accessories", 2),
          _buildBarItem(Icons.adjust_outlined, "Tyre & All...", 3),
          _buildBarItem(Icons.sell_outlined, "Preowned", 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The Pill Background behind the Icon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.selectedPillColor : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              size: 26,
              color: isSelected ? AppColors.selectedIconColor : AppColors.unselectedIconColor,
            ),
          ),
          const SizedBox(height: 6),
          // The Label
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}