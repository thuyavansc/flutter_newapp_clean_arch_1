// import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_newapp_clean_arch_1/core/constants/constants.dart';
import 'package:flutter_newapp_clean_arch_1/core/resources/data_state.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/data/models/article.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository{
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async{
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey:newsAPIKey,
        country:countryQuery,
        category:categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(e){
      return DataFailed(e);
    }
  }
}

