import 'dart:async';
import 'package:budgetpal/category_bloc/category_event.dart';
import 'package:budgetpal/category_bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  // TODO: Initialize your repository here.

  CategoryBloc() : super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    // TODO: Implement your event handlers here.
  }
}
