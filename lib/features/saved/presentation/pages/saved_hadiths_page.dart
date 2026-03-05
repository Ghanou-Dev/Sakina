import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_hadith_cubit/saved_hadith_cubit.dart';
import 'package:sakina/features/saved/presentation/widgets/custom_saved_hadith_item.dart';

class SavedHadithsPage extends StatefulWidget {
  const SavedHadithsPage({
    super.key,
  });

  @override
  State<SavedHadithsPage> createState() => _SavedHadithsPageState();
}

class _SavedHadithsPageState extends State<SavedHadithsPage> {
  SearchController searchController = SearchController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Saved Hadiths',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: BlocBuilder<SavedHadithCubit, SavedHadithState>(
        builder: (context, state) {
          final List<SavedHadithEntity> allSaved = state.savedHadiths;
          // final Set<String> allSavedIds = state.savedIds;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Focus(
                  focusNode: focusNode,
                  child: SearchAnchor.bar(
                    barHintText: 'Search',
                    barTrailing: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ],
                    searchController: searchController,
                    suggestionsBuilder: (context, controller) {
                      return [];
                    },
                    onClose: () {
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allSaved.length,
                  itemBuilder: (context, index) {
                    return CustomSavedHadithItem(savedHadith: allSaved[index]);
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
