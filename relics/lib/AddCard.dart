import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCreditCardScreen extends StatefulWidget {
    final Map<String, dynamic>? initialCardData; // Accept initial card data

  AddCreditCardScreen({this.initialCardData});

  @override
  _AddCreditCardScreenState createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  String _selectedCardType = 'MasterCard'; // Default card type

  // Map card types to logo assets
  final Map<String, String> _cardTypeLogos = {
    'MasterCard': 'assets/mastercard_logo.png',
    'Visa': 'assets/visa_logo.png',
    'Paypal': 'assets/paypal_logo.png',
    'Maestro': 'assets/maestro_logo.png',
  };
@override
  void initState() {
    super.initState();
    // Populate fields with initial card data if available
    if (widget.initialCardData != null) {
      _cardNumberController.text = widget.initialCardData!['CardNum'];
      _cvvController.text = widget.initialCardData!['CardCVV'];
      _cardHolderController.text = widget.initialCardData!['CardHolder'];
      _selectedCardType = widget.initialCardData!['CardType'];
    }
  }

  Widget _buildCardTypeSelector() {
    return DropdownButtonFormField(
      value: _selectedCardType,
      onChanged: (value) {
        setState(() {
          _selectedCardType = value.toString();
        });
      },
      items: _cardTypeLogos.keys.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
    );
  }

  void _addCreditCard(BuildContext context) async {
    String cardNumber = _cardNumberController.text;
    String cvv = _cvvController.text;
    String cardHolder = _cardHolderController.text;

    // Validate input here

    // Store credit card information in Firestore
    try {
      await FirebaseFirestore.instance.collection('CardPaymentData').doc().set({
        'CardNum': cardNumber,
        'CardCVV': cvv,
        'CardHolder': cardHolder,
        'CardType': _selectedCardType,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Credit card added successfully'),
      ));
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add credit card: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Credit Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTypeSelector(),
            SizedBox(height: 16.0),
            Image.asset(
              _cardTypeLogos[_selectedCardType] ?? '',
              width: 100,
              height: 50,
            ),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: _cvvController,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            TextField(
              controller: _cardHolderController,
              decoration: InputDecoration(labelText: 'Cardholder Name'),
            ),
            // Add more input fields as needed
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _addCreditCard(context),
              child: Text('Add Card'),
            ),
          ],
        ),
      ),
    );
  }
}
