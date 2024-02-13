import 'package:flutter/material.dart';

// Model for product
class Product {
  final String name;
  final String price;
  final String imageURL; // Add imageURL field

  Product({required this.name, required this.price, required this.imageURL});
}

// Mock data for products
List<Product> products = [
  Product(
    name: "Buzzlightyear Hasbro 2001",
    price: "550.00 Baht",
    imageURL: "https://down-th.img.susercontent.com/file/4d330710c70bfcd02ad52cc11a239f98_tn",
  ),
  Product(
    name: "Buzzlightyear Takara Tomy",
    price: "700.00 Baht",
    imageURL: "https://down-th.img.susercontent.com/file/th-11134207-23030-omuffg4b8govd2",
  ),
  Product(
    name: "Shin Ultraman Takara Tomy",
    price: "800.00 Baht",
    imageURL: "https://th-test-11.slatic.net/p/6be0f584c1e19a3757b46491ccb6027c.jpg",
  ),
  Product(
    name: "Shin Ultraman Banpresto",
    price: "890.00 Baht",
    imageURL: "https://inwfile.com/s-dr/26s9sv.jpg",
  ),
  Product(
    name: "Spiderman Far from home Hot toys",
    price: "8900.00 Baht",
    imageURL: "https://m.media-amazon.com/images/I/5121q+XJb7L._AC_SL1000_.jpg",
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductSearch(),
    );
  }
}

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search products...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResult(query: _controller.text),
                ),
              );
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final String query;

  SearchResult({required this.query});

  @override
  Widget build(BuildContext context) {
    List<Product> _searchResults = [];
    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        _searchResults.add(product);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2, // Add elevation for a shadow effect
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Add margin for spacing between cards
            child: Container(
              width: double.infinity, // Set width to match the screen width
              padding: EdgeInsets.all(10), // Add padding for spacing within the container
              child: Row(
                children: [
                  Container(
                    width: 150, // Fixed width for the image
                    height: 150, // Fixed height for the image
                    child: Image.network(
                      _searchResults[index].imageURL,
                      fit: BoxFit.contain, // Adjusts the image to cover the entire space
                    ),
                  ),
                  SizedBox(width: 10), // Add spacing between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _searchResults[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5), // Add spacing between title and subtitle
                        Text(
                          'Price: ${_searchResults[index].price}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
