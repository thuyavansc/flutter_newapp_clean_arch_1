import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/presentation/bloc/article/remote/remote_state.dart';
import 'package:flutter_newapp_clean_arch_1/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }
  _buildAppbar(){
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.lightBlueAccent,
          //backgroundColor: Colors.yellow,
          fontSize: 30,
        ),
      ),
    );
  }

  _buildBody(){
    return BlocBuilder<RemoteArticlesBloc,RemoteArticlesState>(
      builder:(_,state){
        if(state is RemoteArticlesLoading){
          return const Center(child: CupertinoActivityIndicator(),);
        }
        if(state is RemoteArticlesError){
          return const Center(child: Icon(Icons.refresh),);
        }
        if(state is RemoteArticlesDone){
          return ListView.builder(
              itemBuilder: (context, index){
                return ArticleWidget(
                  article: state.articles![index],
                );
                  ListTile(title: Text('$index',));
              },
          );
        }
        return const SizedBox(height: 10,);
      },
    );
  }

   _buildBody0() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RemoteArticlesError) {
          return Center(child: Text('Error: ${state.error?.message ?? "Unknown error"}'));
        } else if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.articles![index].title ?? ''),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }


}
