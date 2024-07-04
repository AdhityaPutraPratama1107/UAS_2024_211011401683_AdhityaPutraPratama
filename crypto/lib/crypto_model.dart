import 'package:intl/intl.dart';

class Crypto {
  final int rank;
  final String name;
  final String symbol;
  final double priceUsd;
  final double priceIdr;
  final double priceUsdt;

  Crypto({
    required this.rank,
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceIdr,
    required this.priceUsdt,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    int rank = json['rank'];
    double usd = double.parse(json['price_usd']);
    double idr = usd * 14000; // Asumsi kurs USD ke IDR adalah 14,000
    return Crypto(
      rank: rank,
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: usd,
      priceIdr: idr,
      priceUsdt: usd, // Asumsi 1 USDT ≈ 1 USD
    );
  }

  String get formattedPriceUsd => NumberFormat.currency(symbol: "\$", decimalDigits: 2).format(priceUsd);
  String get formattedPriceIdr => NumberFormat.currency(locale: 'id_ID', symbol: "Rp", decimalDigits: 0).format(priceIdr);
  String get formattedPriceUsdt => NumberFormat.currency(symbol: "USDT ", decimalDigits: 2).format(priceUsdt);
}
