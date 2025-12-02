import '../../../auth/domain/entities/profile.dart';

class FriendRequest {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;
  final Profile? fromUser;
  final Profile? toUser;

  FriendRequest({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
    this.fromUser,
    this.toUser,
  });

  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isRejected => status == 'rejected';
}

