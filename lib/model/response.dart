import 'dart:convert';

class MyResponse {
    bool success;
    String message;
    String token;

    MyResponse({
        required this.success,
        required this.message,
        required this.token,
    });

    factory MyResponse.fromJson(String str) => MyResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MyResponse.fromMap(Map<String, dynamic> json) => MyResponse(
        success: json["success"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "token": token,
    };
}


class WsResponse {
    int code;
    String message;

    WsResponse({
        required this.code,
        required this.message,
    });

    factory WsResponse.fromJson(String str) => WsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WsResponse.fromMap(Map<String, dynamic> json) => WsResponse(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
    };
}
