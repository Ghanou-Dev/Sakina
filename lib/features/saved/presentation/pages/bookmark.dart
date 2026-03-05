import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_hadith_cubit/saved_hadith_cubit.dart';
import 'package:sakina/features/saved/presentation/pages/saved_ayahs_page.dart';
import 'package:sakina/features/saved/presentation/pages/saved_hadiths_page.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Favoriet'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Ink(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Ink(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 2,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: FavorietBody(),
          ),
        ],
      ),
    );
  }
}

class FavorietBody extends StatelessWidget {
  const FavorietBody({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: EdgeInsets.all(6),
      shrinkWrap: true,
      children: [
        CustomFavorietPart(
          partName: 'Ayah',
          pathIcon: 'assets/icons/surah_text_icon.svg',
          onTap: () async {
            await context.read<SavedAyahCubit>().getSavedAyaht();
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SavedAyahsPage()));
          },
        ),
        CustomFavorietPart(
          partName: 'Surah',
          pathIcon: 'assets/icons/listen_icon.svg',
          onTap: () {},
        ),

        CustomFavorietPart(
          partName: 'Hadith',
          pathIcon: 'assets/icons/surah_text_icon.svg',
          onTap: () async {
            await context.read<SavedHadithCubit>().getSavedHadith();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SavedHadithsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CustomFavorietPart extends StatelessWidget {
  final String partName;
  final String pathIcon;
  final void Function()? onTap;
  const CustomFavorietPart({
    required this.partName,
    required this.pathIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.black45,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    partName,
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: SvgPicture.asset(
                    pathIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
