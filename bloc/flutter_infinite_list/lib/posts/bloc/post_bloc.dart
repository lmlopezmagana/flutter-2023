import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:get_it/get_it.dart';
//import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';


part 'post_event.dart';
part 'post_state.dart';

//const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(/*{required this.httpClient}*/) : super(const PostState()) {
  //PostBloc({required this.repo}) : super(const PostState()) {
    repo = GetIt.I.get<PostRepository>();
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  
  late PostRepository repo;


  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        //final posts = await _fetchPosts();
        final posts = await repo.fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      //final posts = await _fetchPosts(state.posts.length);
      final posts = await repo.fetchPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
  
}