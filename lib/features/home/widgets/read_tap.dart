import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          final infoSuwars = context.read<HomeCubit>().allSuwarsInfo;
          return ListView.builder(
            itemCount: infoSuwars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: ItemSurahInfo(
                      surahName: infoSuwars[index].surahName,
                      surahNameArabic: infoSuwars[index].surahNameArabic,
                      surahNameArabicLong:
                          infoSuwars[index].surahNameArabicLong,
                      surahNameTranslation:
                          infoSuwars[index].surahNameTranslation,
                      revelationPlace: infoSuwars[index].revelationPlace,
                      totalAyah: infoSuwars[index].totalAyah,
                      index: index + 1,
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        }
      },
    );
  }
}
