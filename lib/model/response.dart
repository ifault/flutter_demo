import 'dart:convert';
MyResponse myResponseFromMap(String str) => MyResponse.fromMap(json.decode(str));

String myResponseToMap(MyResponse data) => json.encode(data.toMap());

class MyResponse {
    bool? success;
    String? message;
    Data? data;

    MyResponse({
        this.success,
        this.message,
        this.data,
    });

    factory MyResponse.fromMap(Map<String, dynamic> json) => MyResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    String? token;
    int? userId;

    Data({
        this.token,
        this.userId,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "user_id": userId,
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
