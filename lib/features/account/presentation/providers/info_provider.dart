import 'package:flutter/material.dart';
import 'package:pas_mobile/features/account/domain/usecases/get_info.dart';
import 'package:pas_mobile/features/account/presentation/providers/info_state.dart';

class InfoProvider extends ChangeNotifier {
  final GetInfo getAboutUs;

  InfoProvider({required this.getAboutUs});

  Stream<InfoState> getAbout() async* {
    yield InfoLoading();
    final result = await getAboutUs();
    yield* result.fold((failure) async* {
      yield InfoFailure(failure);
    }, (data) async* {
      yield InfoLoaded(data: data);
    });
  }
}
