
class UpdateProfile {
  UpdateProfile({
      this.type, 
      this.properties,});

  UpdateProfile.fromJson(dynamic json) {
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

class Properties {
  Properties({
      this.message,});

  Properties.fromJson(dynamic json) {
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  Message? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message?.toJson();
    }
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