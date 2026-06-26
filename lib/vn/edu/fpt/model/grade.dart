class Grade {
  final int? gradeId;
  final String studentCode;
  final String fullName;
  final String subjectName;
  final double score;
  final int semester;
  final String academicYear;

  Grade({
    this.gradeId,
    required this.studentCode,
    required this.fullName,
    required this.subjectName,
    required this.score,
    required this.semester,
    required this.academicYear,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      gradeId: json['gradeId'],
      studentCode: json['studentCode'],
      fullName: json['fullName'],
      subjectName: json['subjectName'],
      score: (json['score'] as num).toDouble(),
      semester: json['semester'],
      academicYear: json['academicYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeId': gradeId,
      'studentCode': studentCode,
      'fullName': fullName,
      'subjectName': subjectName,
      'score': score,
      'semester': semester,
      'academicYear': academicYear,
    };
  }
}
