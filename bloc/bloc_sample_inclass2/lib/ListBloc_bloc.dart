import 'package:ff_bloc/ff_bloc.dart';

import 'package:bloc_sample_inclass2/index.dart';

class ListBlocBloc extends FFBloc<ListBlocEvent, ListBlocState> {
  ListBlocBloc({    
    required this.provider,
    super.initialState = const ListBlocState(),
  });

  final ListBlocProvider provider;

  @override
  ListBlocState onErrorState(Object error) => state.copy(error: error, isLoading: false);

}
