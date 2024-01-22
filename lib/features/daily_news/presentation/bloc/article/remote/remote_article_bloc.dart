
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/presentation/bloc/article/remote/remote_state.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecase/get_article.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent,RemoteArticlesState> {

  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()){
    on <GetArticles> (onGetArticles);
  }


  void onGetArticles(GetArticles event, Emitter < RemoteArticlesState > emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data.toString());

      emit(
          RemoteArticlesDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      print(dataState.error);

      emit(
          RemoteArticlesError(dataState.error!)
      );
    }
  }

}