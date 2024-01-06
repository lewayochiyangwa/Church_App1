
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


class SermonsModel {
  final String id;
  final String verse;
  final String title;
  final String description;
  final String time_date;


  SermonsModel({
    required this.id,
    required this.verse,
    required this.title,
    required this.description,
    required this.time_date
  });

  factory SermonsModel.fromJson(Map<String, dynamic> json) {
    return SermonsModel(
        id: json['id'],
        verse: json['verse'],
        title: json['sermon_title'],
        description: json['description'],
        time_date: json['time_stamp']
    );
  }
}

