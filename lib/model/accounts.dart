// To parse this JSON data, do
//
//     final accounts = accountsFromMap(jsonString);

import 'dart:convert';

Accounts accountsFromMap(String str) => Accounts.fromMap(json.decode(str));

String accountsToMap(Accounts data) => json.encode(data.toMap());

class Accounts {
    bool? success;
    String? message;
    Data? data;

    Accounts({
        this.success,
        this.message,
        this.data,
    });

    factory Accounts.fromMap(Map<String, dynamic> json) => Accounts(
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
    List<Account>? free;
    List<Account>? waiting;
    List<Account>? pending;

    Data({
        this.free,
        this.waiting,
        this.pending,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        free: json["free"] == null ? [] : List<Account>.from(json["free"]!.map((x) => Account.fromMap(x))),
        waiting: json["waiting"] == null ? [] : List<Account>.from(json["waiting"]!.map((x) => Account.fromMap(x))),
        pending: json["pending"] == null ? [] : List<Account>.from(json["pending"]!.map((x) => Account.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "free": free == null ? [] : List<dynamic>.from(free!.map((x) => x.toMap())),
        "waiting": waiting == null ? [] : List<dynamic>.from(waiting!.map((x) => x.toMap())),
        "pending": pending == null ? [] : List<dynamic>.from(pending!.map((x) => x.toMap())),
    };
}

class Account {
    String? uuid;
    String? username;
    String? password;
    String? details;
    String? status;
    String? order;
    String? orderTime;
    String? taskId;

    Account({
        this.uuid,
        this.username,
        this.password,
        this.details,
        this.status,
        this.order,
        this.orderTime,
        this.taskId,
    });

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        uuid: json["uuid"],
        username: json["username"],
        password: json["password"],
        details: json["details"],
        status: json["status"],
        order: json["order"],
        orderTime: json["order_time"],
        taskId: json["task_id"],
    );

    Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "username": username,
        "password": password,
        "details": details,
        "status": status,
        "order": order,
        "order_time": orderTime,
        "task_id": taskId,
    };
}
