import 'package:flutter_newapp_clean_arch_1/core/resources/data_state.dart';
import 'package:flutter_newapp_clean_arch_1/core/usecases/usecase.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, void>{
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    // TODO: implement call
    //throw UnimplementedError();
    print(_articleRepository.getNewsArticles().toString());
    return _articleRepository.getNewsArticles();
  }

}