class Auction {
  int id;
  DateTime startTime;
  DateTime endTime;
  int productId;

  Auction({required this.id, required this.startTime, required this.endTime, required this.productId});

  Map<String, dynamic> toMap() {
    return {
      'auction_id': id,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'product_id': productId,
    };
  }

  factory Auction.fromMap(Map<String, dynamic> map) {
    return Auction(
      id: map['auction_id'],
      startTime: DateTime.parse(map['start_time']),
      endTime: DateTime.parse(map['end_time']),
      productId: map['product_id'],
    );
  }
}