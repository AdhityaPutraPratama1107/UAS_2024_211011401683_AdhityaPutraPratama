import 'dart:convert';
import 'package:http/http.dart' as http;
import 'crypto_model.dart';

Future<List<Crypto>> fetchCryptos() async {
  final response = await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> cryptosJson = data['data'];

    return cryptosJson.map((json) => Crypto.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load cryptos');
  }
}
