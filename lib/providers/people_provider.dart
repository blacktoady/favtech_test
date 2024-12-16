import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/person.dart';

final peopleProvider = FutureProvider<List<Person>>((ref) async {
  final response = await Dio().get(
      'https://api.themoviedb.org/3/person/popular?api_key=92273e97471acce832cb46253d46f0ee');
  final results = response.data['results'] as List;
  return results.map((json) => Person.fromJson(json)).toList();
});
