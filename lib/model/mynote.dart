// reason to do
// database required json data 
// db file is database file
// we will create packet can be called as object
// this will act as intermediate between the database and mobile applications
//  a static member in Dart (the language used by Flutter) belongs to the class itself rather than to any specific instance of the class. This means that you can access a static member without creating an object of the class.
class NotesImpnames {
  static final String id = "id";
  static final String pin = "pin";
  static final String title = "title";
  static final String content = "content";
  static final String createdTime = "createdTime";
  static final String tableaName = "Notes";
  static final List<String> value = [
    id,
    pin,
    title,
    content,
    createdTime,
    tableaName
  ];
}

class note {
  // name should be same in db query CREATE

  final int? id;
  final bool pin;
  final String title;
  final String content;
  final DateTime createdTime;

  const note(
      {this.id,
      required this.pin,
      required this.title,
      required this.content,
      required this.createdTime});

// function to convert json to object
// return instance of an object of class note
//input is Map jsonREC
// return note object 
  static note fromJson(Map<String, Object?> jsonREC) {
    return note(
        id: jsonREC[NotesImpnames.id] as int?, // as is used for type casting 
        pin: jsonREC[NotesImpnames.pin] == true as bool,
        title: jsonREC[NotesImpnames.title] as String,
        content: jsonREC[NotesImpnames.content] as String,
        createdTime:
            DateTime.parse(jsonREC[NotesImpnames.createdTime] as String));
  }

// return map from the object data variables 
// used for database 
  Map<String, Object?> toJson() {
    return {
      NotesImpnames.id: id,
      NotesImpnames.pin: pin ? 1 : 0,
      NotesImpnames.title: title,
      NotesImpnames.content: content,
      NotesImpnames.createdTime:
          createdTime.toIso8601String() // forammted string conversion
    };
  }
//In Flutter and Dart, the ?? operator is called the null-aware operator or null-coalescing operator. It is used to provide a default value when a nullable variable is null.

// Here's how id ?? this.id works in Flutter:

// Assuming you have a variable id that may or may not be null, and you want to use its value if it's not null and fall back to this.id if it is null.

// If id is not null, the expression evaluates to the value of id.
// If id is null, the expression evaluates to this.id.

// function return an note object 
  note copy(
      {int? id,
      bool? pin,
      String? title,
      String? content,
      DateTime? createdTime}) {

        
    return note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        title: title ?? this.title,
        content: content ?? this.content,
        createdTime: createdTime ?? this.createdTime);
  }
}
