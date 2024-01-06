
class EventsModel {
  final String id;
  final String title;
  final String location;
  final String toTime;
  final String fromTime;
  final String description;

  EventsModel({
    required this.id,
    required this.title,
    required this.location,
    required this.toTime,
    required this.fromTime,
    required this.description,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      toTime: json['timeTo'],
      fromTime: json['timeFrom'],
      description: json['description']
    );
  }
}


