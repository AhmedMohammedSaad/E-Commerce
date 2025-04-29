import 'package:advanced_app/core/apikey.dart';
import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/textStyle/text_style.dart';
import 'package:advanced_app/features/Cart/data/models/cart_model/cart_model.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/chckout_and_delete.dart';
import 'package:advanced_app/features/Cart/presentation/widgets/counter_add_and_remove.dart';
import 'package:advanced_app/features/Profile/data/models/get_data_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class CardCategory extends StatefulWidget {
  const CardCategory({
    super.key,
    required this.cartModel,
    required this.carts,
    required this.index,
  });

  final CartModel cartModel;
  final List<CartModel> carts;
  final int index;

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  GetDataUser? userData;
  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          apiKeyForBayMob, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      //  Optional User Data
      userData: UserData(
        email: userData?.email ?? "aaaaa", // Optional: Defaults to 'NA'
        //   phone: "User Phone", // Optional: Defaults to 'NA'
        name: userData?.name ?? "aaaaa", // Optional: Defaults to 'NA'
        //   lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.primaryColor, // Default: Colors.blue
        scaffoldColor: AppColors.white, // Default: Colors.white
        appBarBackgroundColor: AppColors.primaryColor, // Default: Colors.blue
        appBarForegroundColor: AppColors.white, // Default: Colors.white
        textStyle: const TextStyle(), // Default: TextStyle()
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.primaryColor, // Default: Colors.blue
        unselectedColor: AppColors.primaryColor, // Default: Colors.grey
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      height: 150.h,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // لون أسود مع شفافية
            offset: Offset(1, 1), // اتجاه ومسافة الظل
            blurStyle: BlurStyle.normal, // تأثير طبيعي على الحواف
            spreadRadius: 1, // عرض الظل
            blurRadius: 7, // نعومة الظل
          ),
        ],
        border: Border.all(color: AppColors.primaryColor),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      //!
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! this sizdBox is for size image and style
          SizedBox(
            height: 150.h,
            width: 150.w,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                bottomLeft: Radius.circular(14.r),
              ),
              //! image
              child: CachedNetworkImage(
                imageUrl: widget.cartModel.products!.imageUrl.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    border: const Border.symmetric(
                        vertical: BorderSide(color: AppColors.primaryColor)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  height: 185.h,
                  width: 200.w,
                  child: Card(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 90,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 13.h,
              children: [
                //! prodoct name
                SizedBox(
                  width: 160.w,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.cartModel.products!.productName.toString(),
                    style: StyleTextApp.font14ColorblacFontWeightBold,
                  ),
                ),
                //! counter add and remove
                CunterAddandRemove(
                  price: widget.cartModel,
                ),
                //! checkout and delete Buttons
                ChackoutAndDelete(
                  product: widget.carts,
                  index: widget.index,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
