import 'package:flutter/material.dart';
import '../../utils/flutter_color_themes.dart';
import '../../utils/flutter_font_style.dart';

class ProductDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const ProductDetailsAppBar({
    super.key,
    this.title = "",
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: AppColors.appThemes,
      elevation: 0,

      centerTitle: false,
      titleSpacing: 0,

      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),

      title: Text(
        title,
        style: FTextStyle.appbar(context).copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionIcon(Icons.notifications_none, () {}),
            _buildActionIcon(Icons.favorite_border, () {}),
            _buildActionIcon(Icons.shopping_cart_outlined, () {}),
            _buildActionIcon(Icons.person_outline, () {}),
            const SizedBox(width: 8), // Right side se thoda gap
          ],
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: 38,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints:  BoxConstraints(),
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(kToolbarHeight);
}