import 'package:flutter/material.dart';
import 'size_config.dart';
import 'flutter_color_themes.dart';

class FTextStyle {


  static TextStyle sin(BuildContext context) => TextStyle(
    fontFamily: 'Nunito',
    fontSize: getResponsiveFontSize(context, 22),
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle appbar(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 20),
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle enterEmailAndPhone(BuildContext context) => TextStyle(
    fontFamily: 'Nunito', // Updated font family
    fontWeight: FontWeight.w400, // Regular weight (400)
    fontSize: getResponsiveFontSize(context, 14), // 14px
    color: AppColors.grey

  );
  static TextStyle continueGoogle(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle terms(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 13),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.create
        : AppColors.create,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle forgetPassword(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email, // Keep AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle createAccount(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 19),
    fontWeight: FontWeight.w800,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? AppColors.create
        : AppColors.create,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle loginIntoYourAccount(BuildContext context) => TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: getResponsiveFontSize(context, 24),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle emailText(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email, // Use AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle hintText(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.hintColour, // Keep existing
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle login(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle howSalvagingWorks(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle solvaging1(BuildContext context) => TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, 23.32),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle onboardingTitle(BuildContext context) => TextStyle(
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeight.w700,
    fontSize: getResponsiveFontSize(context, 24),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle onboardLogin(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.black,
  );

  static TextStyle profileText(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 22),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black, // Use AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle profileEmailNumber(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 17),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black, // Use AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle profileListItem(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w600,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black, // Use AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle placeholder(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w600,
    color: Colors.grey, // 👈 single fixed color
    textBaseline: TextBaseline.alphabetic,
  );



  static TextStyle appBarTitle(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans', // Match "DM Sans"
    fontSize: getResponsiveFontSize(context, 20), // Font size: 10px
    fontWeight: FontWeight.w400, // font-weight: 400
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle description(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle ticketSupport(BuildContext context) => TextStyle(
    fontFamily: 'Nunito Sans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );


  static TextStyle recentSearch(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w600, // was w500, changed to match spec
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.black,
    textBaseline: TextBaseline.alphabetic,
  );



  static TextStyle viewDetails(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
  );

  static TextStyle text(BuildContext context) => TextStyle(
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 24),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle sortFilter(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle title(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle price(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w600,
    fontSize: getResponsiveFontSize(context, 16),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle delivery(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 12),

    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle previousPurch(BuildContext context) => TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, 20),

    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle ViewDetails(BuildContext context) => TextStyle(
    fontFamily: 'DMSans', // Match "DM Sans"
    fontSize: getResponsiveFontSize(context, 12), // Font size: 10px
    fontWeight: FontWeight.w400, // font-weight: 400
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle verticalline(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w900,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );


  static TextStyle ShowingSearchResults(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 16), // 👈 14px
    fontWeight: FontWeight.w400, // 👈 700 (Bold)
    fontStyle: FontStyle.normal, // 👈 Bold ke sath Normal rakha
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic, // 👈 leading-trim equivalent
  );

  static TextStyle filterSearchResults(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 14), // 👈 14px
    fontWeight: FontWeight.w500, // 👈 Medium
    fontStyle: FontStyle.normal, // 👈 Medium ke sath normal
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic, // 👈 leading-trim equivalent
  );


  // Showing search results for: Metal pipes
  static TextStyle profileTitle(BuildContext context) => TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle profileDes(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 13),

    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle uploadimg(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle selectFile(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(context, 14),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle addListingText(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle addListingText1(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle productDetailsTitle(BuildContext context) => TextStyle(
    fontFamily: 'Nunito',
    fontSize: getResponsiveFontSize(context, 20),
    fontWeight: FontWeight.bold,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle productDetailsPrice(BuildContext context) => TextStyle(
    fontFamily: 'Nunito',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.bold,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle productListedDetails(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 12),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle productItemStatus(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 12),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle productItem(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 12),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle productSaveItemBtn(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );


  static TextStyle productDetailsDes(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle productConditionLabel(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 12),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle productConditionLabel1(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 15),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle deliveryDetails(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 14),
    fontWeight: FontWeight.w700,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle viewMessage(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 20),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );



  static TextStyle messageUser(BuildContext context) => TextStyle(
    fontFamily: 'DMSans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 15),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );



  static TextStyle NewMessageTittle(BuildContext context) => TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: getResponsiveFontSize(context, 18),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle NewMessageDes(BuildContext context) => TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: getResponsiveFontSize(context, 15),
    fontWeight: FontWeight.w400,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    textBaseline: TextBaseline.alphabetic,
  );
  static TextStyle Message(BuildContext context) => TextStyle(
    fontFamily: 'DM_Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle messageDescription(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.w400,
    fontSize: getResponsiveFontSize(context, 15),
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle messageTittle(BuildContext context) => TextStyle(
    fontFamily: 'DM Sans',
    fontSize: getResponsiveFontSize(context, 16),
    fontWeight: FontWeight.w500,
    color:
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : AppColors.email, // Use AppColors.email in light mode
    textBaseline: TextBaseline.alphabetic,
  );

  static double getResponsiveFontSize(BuildContext context, double size) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double baseSize;
    if (isLandscape) {
      baseSize = SizeConfig.screenHeight;
    } else {
      baseSize = SizeConfig.screenWidth;
    }
    return baseSize * 0.0024 * size * textScale;
    // return size * textScale;
  }

//  style: FTextStyle.sin(context).copyWith(color: AppColors.brand), // sortFilter
}