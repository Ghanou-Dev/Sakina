import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/pages/display_all_moshafs.dart';
import 'package:sakina/features/home/widgets/listen_tap/reciter_item.dart';

class Listen extends StatefulWidget {
  const Listen({super.key});

  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final reciters = context.read<ListenCubit>().recitersList;
    if (reciters.isNotEmpty) {
      return ListView.builder(
        itemCount: reciters.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayAllMoshafs(
                        reciter: reciters[index],
                      ),
                    ),
                  );
                },
                splashColor: AppColors.silver.withAlpha(150),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: ReciterItem(
                  reciter: reciters[index],
                  index: index + 1,
                ),
              ),
              Divider(),
            ],
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
