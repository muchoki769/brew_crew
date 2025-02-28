import 'package:brew_crew/components/my_button.dart';
import 'package:brew_crew/screens/home/delivery_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName ='';
  String cvvCode = '';
  // bool showBackView = false;
  bool isCvvFocused = false;
  OutlineInputBorder? border;

  //user wants to pay
  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      //only show dialog if form is valid
      showDialog(context: context,
          builder: (context) => AlertDialog(
            title: const  Text("Confirm payment"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                 Text("Card Number: $cardNumber"),
                  Text("Expiry Date: $expiryDate"),
                  Text("Card Holder Name: $cardHolderName"),
                  Text("CVV Code: $cvvCode"),
                ],
              ),
            ),
            actions: [
              //cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              
              ),
              //yes button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                       context,
                  MaterialPageRoute(
                    builder: (context) =>  DeliveryProgress(),
                  ),
                );
              },

                child: const Text("Yes"),

              ),
            ],
          )
      );
      debugPrint('valid');
    }else {
      debugPrint('invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //credit
          CreditCardWidget(cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0) {

              },
          ),

          //credit card form
          CreditCardForm(cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
               setState(() {
                 cardNumber = data.cardNumber;
                 expiryDate = data.expiryDate;
                 cardHolderName = data.cardHolderName;
                 cvvCode = data.cvvCode;
                 // isCvvFocused = data.isCvvFocused;
               });

              },
              formKey: formKey,
          ),
          const Spacer(),

          MyButton(onTap: userTappedPay,
              child: Text("Pay Now")
          ),
          const SizedBox(height: 25.0,)
        ],

      ),
    );
  }
}
