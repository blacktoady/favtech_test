import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/people_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PeopleListWidget extends ConsumerStatefulWidget {
  const PeopleListWidget({super.key});

  @override
  PeopleListWidgetState createState() => PeopleListWidgetState();
}

class PeopleListWidgetState extends ConsumerState<PeopleListWidget> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  void _scrollToSelectedIndex(int index) {
    _scrollController.animateTo(
      (index - 1) * 156.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final people = ref.watch(peopleProvider);

    return people.when(
      data: (peopleList) => Container(
        color: Colors.white,
        height: 170, 
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: peopleList.length,
          itemBuilder: (context, index) {
            final person = peopleList[index];
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                _scrollToSelectedIndex(index);
              },
              child: Container(
                width: 140,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade100 : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 5.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${person.profilePath}',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      person.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Popularity: ${person.popularity.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading people')),
    );
  }
}
