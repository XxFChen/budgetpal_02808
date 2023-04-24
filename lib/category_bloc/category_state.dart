import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<String> categories;

  CategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {}
