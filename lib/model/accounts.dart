import 'dart:convert';

class Accounts {
    List<Account> free;
    List<Account> waiting;
    List<Account> pending;

    Accounts({
        required this.free,
        required this.waiting,
        required this.pending,
    });

    factory Accounts.fromJson(String str) => Accounts.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Accounts.fromMap(Map<String, dynamic> json) => Accounts(
        free: List<Account>.from(json["free"].map((x) => Account.fromMap(x))),
        waiting: List<Account>.from(json["waiting"].map((x) => Account.fromMap(x))),
        pending: List<Account>.from(json["pending"].map((x) => Account.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "free": List<dynamic>.from(free.map((x) => x.toMap())),
        "waiting": List<dynamic>.from(waiting.map((x) => x.toMap())),
        "pending": List<dynamic>.from(pending.map((x) => x.toMap())),
    };
}

class Account {
    String username;
    String details;
    String status;
    String uuid;

    Account({
        required this.username,
        required this.details,
        required this.status,
        required this.uuid,
    });

    factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Account.fromMap(Map<String, dynamic> json) => Account(
        username: json["username"],
        details: json["details"],
        status: json["status"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "details": details,
        "status": status,
        "uuid": uuid,
    };
}
