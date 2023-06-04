import 'package:flutter/material.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key, required this.onPress});
  final Function onPress;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();

  String _cardNumber = '';
  String _cardHolderName = '';
  String _expiryDate = '';
  String _cvv = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Numéro de Carte',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le numéro de carte';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _cardNumber = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Titulaire de la Carte',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le nom du titulaire de la carte';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _cardHolderName = value;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date d\'expiration',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer la date d\'expiration';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _expiryDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer le CVV';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _cvv = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Informations de la carte :');
                  print('Numéro de carte: $_cardNumber');
                  print('Titulaire de la carte: $_cardHolderName');
                  print('Date d\'expiration: $_expiryDate');
                  print('CVV: $_cvv');
                  widget.onPress();
                }
              },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
