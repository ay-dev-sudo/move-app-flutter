/// type : "object"
/// properties : {"message":{"type":"string"},"data":{"type":"string"}}

class LoginResponse {
  LoginResponse({
      this.type, 
      this.properties,});

  LoginResponse.fromJson(dynamic json) {
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

/// message : {"type":"string"}
/// data : {"type":"string"}

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

/// type : "string"

class Data {
  Data({
      this.type,});

  Data.fromJson(dynamic json) {
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