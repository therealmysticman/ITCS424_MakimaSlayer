import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddCard.dart'; // Import your AddCreditCardScreen

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final Map<String, String> _cardTypeImages = {
    'MasterCard': 'assets/mastercard_logo.png',
    'Visa': 'assets/visa_logo.png',
    'Paypal': 'assets/paypal_logo.png',
    'Maestro': 'assets/maestro_logo.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Cards'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CardPaymentData').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final card = documents[index].data() as Map<String, dynamic>;
              final cardType = card['CardType'];
              final cardNum = card['CardNum'];
              final cardImage = _cardTypeImages[cardType];
              return ListTile(
                leading: cardImage != null
                    ? SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.asset(cardImage),
                      )
                    : Container(),
                title: Text(cardNum),
                subtitle: Text(cardType),
                onTap: () async {
                  final selectedCard = cardNum;
                  final selectedCardImage = cardImage;
                  Navigator.pop(context, {
                    'CardNum': selectedCard,
                    'CardImage': selectedCardImage,
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCreditCardScreen(),
            ),
          );
          if (result != null) {
            // Handle result if needed
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
