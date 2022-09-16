// //     final tokenData = tokenDataFromJson(jsonString);

// import 'dart:convert';

// TokenData tokenDataFromJson(String str) => TokenData.fromJson(json.decode(str));

// String tokenDataToJson(TokenData data) => json.encode(data.toJson());

// class TokenData {
//   TokenData({
//     this.success,
//     this.ethPrice,
//     this.btcPrice,
//   });

//   bool? success;
//   dynamic ethPrice;
//   dynamic btcPrice;

//   factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
//         success: json["success"],
//         ethPrice: json["ethPrice"].toDouble(),
//         btcPrice: json["btcPrice"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "ethPrice": ethPrice,
//         "btcPrice": btcPrice,
//       };
// }
