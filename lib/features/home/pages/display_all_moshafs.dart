import 'package:flutter/material.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/models/reciter_model.dart';
import 'package:sakina/features/home/widgets/listen_tap/moshafe_item.dart';

class DisplayAllMoshafs extends StatelessWidget {
  final ReciterModel reciter;
  const DisplayAllMoshafs({
    required this.reciter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          reciter.name,
          style: TextStyle(
            fontFamily: amiri,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reciter.moshaf.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: MoshafeItem(
                      reciterName: reciter.name,
                      moshafe: reciter.moshaf[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
