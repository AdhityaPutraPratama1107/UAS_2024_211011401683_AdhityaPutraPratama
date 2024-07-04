// main.dart

import 'package:flutter/material.dart';
import 'crypto_model.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indodax',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoListScreen(),
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late Future<List<Crypto>> futureCryptos;
  String selectedCurrency = 'IDR';

  @override
  void initState() {
    super.initState();
    futureCryptos = fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Indodax'),
        actions: [
          DropdownButton<String>(
            value: selectedCurrency,
            items: <String>['IDR', 'USDT'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCurrency = newValue!;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Crypto>>(
        future: futureCryptos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final crypto = snapshot.data![index];
                String price;
                if (selectedCurrency == 'IDR') {
                  price = crypto.formattedPriceIdr;
                } else {
                  price = crypto.formattedPriceUsdt;
                }
                return ListTile(
                  leading: Text('${crypto.rank}.'),
                  title: Text('${crypto.name} (${crypto.symbol})'),
                  trailing: Text(price),
                );
              },
            );
          }
        },
      ),
    );
  }
}
