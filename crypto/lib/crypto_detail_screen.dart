import 'package:flutter/material.dart';
import 'crypto_model.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Crypto crypto;

  CryptoDetailScreen({required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${crypto.name} Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rank: ${crypto.rank}'),
            SizedBox(height: 12),
            Text('Price (USD): ${crypto.formattedPriceUsd}'),
            SizedBox(height: 8),
            Text('Price (IDR): ${crypto.formattedPriceIdr}'),
            SizedBox(height: 8),
            Text('Price (USDT): ${crypto.formattedPriceUsdt}'),
            SizedBox(height: 8),
            Text('24h Volume: ${crypto.volume24h}'),
          ],
        ),
      ),
    );
  }
}
