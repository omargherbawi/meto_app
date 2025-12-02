import '../../domain/entities/friend_request.dart';
import '../../../auth/data/models/profile_model.dart';

class FriendRequestModel extends FriendRequest {
  FriendRequestModel({
    required super.id,
    required super.fromUserId,
    required super.toUserId,
    required super.status,
    required super.createdAt,
    super.fromUser,
    super.toUser,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      id: json['id'],
      fromUserId: json['from_user_id'],
      toUserId: json['to_user_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      fromUser: json['from_user'] != null
          ? ProfileModel.fromJson(json['from_user'])
          : null,
      toUser: json['to_user'] != null
          ? ProfileModel.fromJson(json['to_user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from_user_id': fromUserId,
        'to_user_id': toUserId,
        'status': status,
        'created_at': createdAt.toIso8601String(),
      };
}

