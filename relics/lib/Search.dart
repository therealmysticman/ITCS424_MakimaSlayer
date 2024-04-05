import 'package:flutter/material.dart';
import 'SearchResults.dart';

class Search extends StatefulWidget {
  final String usernameEmail;

  Search({required this.usernameEmail});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7, // Adjust width as needed
                  height: 50.0, // Adjust height as needed
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search toys...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: EdgeInsets.only(left: 16.0), // Adjust left padding as needed
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _performSearch();
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchResultsWidget(),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    // Trigger search logic here
    setState(() {});
  }

  Widget _searchResultsWidget() {
    if (_searchController.text.isEmpty) {
      return Center(child: Text('Enter a search query'));
    } else {
      return SearchResults(searchQuery: _searchController.text, userEmail: widget.usernameEmail);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
