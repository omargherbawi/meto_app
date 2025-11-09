class Meeting {
  final String id;
  final String ownerId;
  final String ?title;
  final String? location;
  final double? latitude;
  final double? longitude;
  final DateTime ?meetingTime;
  final String inviteLink;
  final String status; 
  final DateTime ?date;
  Meeting({
    required this.id,
    required this.ownerId,
    this.title,
    this.location,
    this.latitude,
    this.longitude,
    this.meetingTime,
    required this.inviteLink,
    required this.status,
   this.date,
    
  });
}
