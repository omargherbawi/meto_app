import '../../domain/entities/meeting.dart';

class MeetingModel extends Meeting {
   MeetingModel({
    required super.id,
    required super.ownerId,
    super.title,
    super.location,
    super.latitude,
    super.longitude,
    super.meetingTime,
    required super.inviteLink,
    required super.status,
    super.date,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      title: json['title'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      meetingTime: json['time'] != null
          ? DateTime.parse(json['time'] as String)
          : null,
      inviteLink: json['invite_link'] as String,
      status: json['status'] as String,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'owner_id': ownerId,
        'title': title,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'time': meetingTime?.toIso8601String(),
        'invite_link': inviteLink,
        'status': status,
        'date': date?.toIso8601String(),
      };

  factory MeetingModel.fromEntity(Meeting meeting) {
    return MeetingModel(
      id: meeting.id,
      ownerId: meeting.ownerId,
      title: meeting.title,
      location: meeting.location,
      latitude: meeting.latitude,
      longitude: meeting.longitude,
      meetingTime: meeting.meetingTime,
      inviteLink: meeting.inviteLink,
      status: meeting.status,
      date: meeting.date,
    );
  }
}