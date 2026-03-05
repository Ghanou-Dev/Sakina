import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';

class ReadSurahPage extends StatefulWidget {
  final String index;
  const ReadSurahPage({super.key, required this.index});

  @override
  State<ReadSurahPage> createState() => _ReadSurahPageState();
}

class _ReadSurahPageState extends State<ReadSurahPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final i = context.read<HomeCubit>().fihras[widget.index];
        goToPage(index: i);
      },
    );
  }

  void goToPage({required int index}) {
    final indexPage = index - 1;
    double offset = indexPage * (MediaQuery.of(context).size.height - 36);
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 604,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height - 36,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/moshafe/pages/${index + 1}.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
