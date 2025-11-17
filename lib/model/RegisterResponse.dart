/// type : "object"
/// properties : {"message":{"type":"string"},"data":{"type":"object","properties":{"email":{"type":"string"},"password":{"type":"string"},"name":{"type":"string"},"phone":{"type":"string"},"avaterId":{"type":"number"},"_id":{"type":"string"},"createdAt":{"type":"string"},"updatedAt":{"type":"string"},"__v":{"type":"number"}}}}

class RegisterResponse {
  final String? status;
  final String? message;
  final Map<String, dynamic>? data;

  RegisterResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}


/// message : {"type":"string"}
/// data : {"type":"object","properties":{"email":{"type":"string"},"password":{"type":"string"},"name":{"type":"string"},"phone":{"type":"string"},"avaterId":{"type":"number"},"_id":{"type":"string"},"createdAt":{"type":"string"},"updatedAt":{"type":"string"},"__v":{"type":"number"}}}

class Properties {
  Properties({
      this.message, 
      this.data,});

  Properties.fromJson(dynamic json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Message? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// type : "object"
/// properties : {"email":{"type":"string"},"password":{"type":"string"},"name":{"type":"string"},"phone":{"type":"string"},"avaterId":{"type":"number"},"_id":{"type":"string"},"createdAt":{"type":"string"},"updatedAt":{"type":"string"},"__v":{"type":"number"}}

class Data {
  Data({
      this.type, 
      this.properties,});

  Data.fromJson(dynamic json) {
    type = json['type'];
    properties = json['properties'] != null ? Properties.fromJson(json['properties']) : null;
  }
  String? type;
  Properties? properties;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    return map;
  }

}

/// email : {"type":"string"}
/// password : {"type":"string"}
/// name : {"type":"string"}
/// phone : {"type":"string"}
/// avaterId : {"type":"number"}
/// _id : {"type":"string"}
/// createdAt : {"type":"string"}
/// updatedAt : {"type":"string"}
/// __v : {"type":"number"}

class Register {
  Register({
      this.email, 
      this.password, 
      this.name, 
      this.phone, 
      this.avaterId,
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Register.fromJson(dynamic json) {
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    password = json['password'] != null ? Password.fromJson(json['password']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    phone = json['phone'] != null ? Phone.fromJson(json['phone']) : null;
    avaterId = json['avaterId'] != null ? AvaterId.fromJson(json['avaterId']) : null;
    id = json['_id'] != null ? Id.fromJson(json['_id']) : null;
    createdAt = json['createdAt'] != null ? CreatedAt.fromJson(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? UpdatedAt.fromJson(json['updatedAt']) : null;
    v = json['__v'] != null ? V.fromJson(json['__v']) : null;
  }
  Email? email;
  Password? password;
  Name? name;
  Phone? phone;
  AvaterId? avaterId;
  Id? id;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;
  V? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (email != null) {
      map['email'] = email?.toJson();
    }
    if (password != null) {
      map['password'] = password?.toJson();
    }
    if (name != null) {
      map['name'] = name?.toJson();
    }
    if (phone != null) {
      map['phone'] = phone?.toJson();
    }
    if (avaterId != null) {
      map['avaterId'] = avaterId?.toJson();
    }
    if (id != null) {
      map['_id'] = id?.toJson();
    }
    if (createdAt != null) {
      map['createdAt'] = createdAt?.toJson();
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt?.toJson();
    }
    if (v != null) {
      map['__v'] = v?.toJson();
    }
    return map;
  }

}

/// type : "number"

class V {
  V({
      this.type,});

  V.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class UpdatedAt {
  UpdatedAt({
      this.type,});

  UpdatedAt.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class CreatedAt {
  CreatedAt({
      this.type,});

  CreatedAt.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Id {
  Id({
      this.type,});

  Id.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "number"

class AvaterId {
  AvaterId({
      this.type,});

  AvaterId.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Phone {
  Phone({
      this.type,});

  Phone.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Name {
  Name({
      this.type,});

  Name.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Password {
  Password({
      this.type,});

  Password.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Email {
  Email({
      this.type,});

  Email.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}

/// type : "string"

class Message {
  Message({
      this.type,});

  Message.fromJson(dynamic json) {
    type = json['type'];
  }
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}