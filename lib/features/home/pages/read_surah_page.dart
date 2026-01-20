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
    double offset = index * (MediaQuery.of(context).size.height - 50);
    _scrollController.jumpTo(offset);
  }

  late ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 604,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height - 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/moshafe/pages/$index.png',
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
