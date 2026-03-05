import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:sakina/features/saved/presentation/widgets/custom_saved_ayah_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SavedAyahsPage extends StatefulWidget {
  const SavedAyahsPage({super.key});
  @override
  State<SavedAyahsPage> createState() => _SavedAyahPageState();
}

class _SavedAyahPageState extends State<SavedAyahsPage> {
  SearchController searchController = SearchController();
  FocusNode focusNode = FocusNode();
  ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Saved Ayahs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SavedAyahCubit, SavedAyahState>(
        builder: (context, state) {
          // search bar
          // serching in saved ayah list
          // sorting suwars and ayat

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Focus(
                  focusNode: focusNode,
                  child: SearchAnchor.bar(
                    barTrailing: [
                      IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ],

                    barHintText: 'Search',
                    searchController: searchController,
                    suggestionsBuilder: (context, controller) {
                      final diacritics = RegExp(
                        r'[\u064B-\u0652]',
                      ); // الحركات فقط
                      final list = state.savedAyahsKeys
                          .map(
                            (e) => e
                                .replaceAll(
                                  RegExp(r'[أإ]'),
                                  'ا',
                                ) // استبدال الألف بهمزة بـ ا
                                .replaceAll(diacritics, '') // حذف الحركات فقط
                                .replaceAll(
                                  RegExp(r'\u0671'),
                                  'ا',
                                ), // استبدال الألف الممدودة بـ ا
                          )
                          .toSet();
                      final filtred = list
                          .where(
                            (el) => el.contains(controller.text),
                          )
                          .toList();
                      return filtred.map(
                        (e) {
                          return ListTile(
                            onTap: () {
                              controller.closeView(e);
                            },
                            title: Text(e),
                          );
                        },
                      );
                    },
                    onClose: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      final diacritics = RegExp(
                        r'[\u064B-\u0652]',
                      );
                      final listKeys = state.savedAyahsKeys
                          .map(
                            (e) => e
                                .replaceAll(
                                  RegExp(r'[أإ]'),
                                  'ا',
                                ) // استبدال الألف بهمزة بـ ا
                                .replaceAll(diacritics, '') // حذف الحركات فقط
                                .replaceAll(
                                  RegExp(r'\u0671'),
                                  'ا',
                                ), //
                          )
                          .toList();
                      int idx = listKeys.indexOf(searchController.text);
                      if (idx < 0) {
                        idx = 0;
                      }
                      itemScrollController.scrollTo(
                        index: idx,
                        duration: Duration(seconds: 1),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.savedAyahsList.length,
                  itemScrollController: itemScrollController,
                  itemBuilder: (context, index) {
                    return CustomSavedAyahItem(
                      savedAyah: state.savedAyahsList[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
