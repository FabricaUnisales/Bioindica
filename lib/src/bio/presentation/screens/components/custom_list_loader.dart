import 'package:bioindica/src/bio/data/enums/app_state.dart';
import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

///Classe responsável por auxiliar o carregamento de uma lista, de acordo com o estado dos dados da mesma
class CustomListLoader extends StatelessWidget {
  final bool isSliver;
  final AppState state;
  final bool isEmptyList;
  final Function buildLoadedList;
  final Function buildLoadingList;
  final CustomNotificationState emptyState;
  final CustomNotificationState failureState;

  const CustomListLoader({
    super.key,
    required this.state,
    required this.isEmptyList,
    required this.buildLoadedList,
    required this.buildLoadingList,
    required this.emptyState,
    required this.failureState,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {

    if (state == AppState.initial) {
      return _checkSliverStructure(
        context,
        child: Center(
          child: Lottie.asset(
            'assets/lotties/loading_lottie.json',
            repeat: true,
            reverse: false,
            animate: true,
            width: 70.0.s,
          ),
        ),
      );
    } else if (state == AppState.loaded) {
      return isEmptyList ? _checkSliverStructure(context, child: emptyState) : buildLoadedList();
    } else if (state == AppState.loading) {
      return buildLoadingList();
    } else if (state == AppState.failure) {
      return _checkSliverStructure(context, child: failureState);
    }

    return Center(child: Text('Estado inesperado: $state'));
  }

  Widget _checkSliverStructure(BuildContext context, {required Widget child}) {
    return isSliver
      ? SliverFillRemaining(child: child)
      : SizedBox(height: 100.h, width: 120.w, child: child);
  }
}
