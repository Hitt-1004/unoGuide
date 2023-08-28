// List<Map<String, dynamic>> studentRecords = [
//   {
//     "testName": "Sheet1",
//     "addNo": 8767,
//     "firstname": "alex",
//     "lastname": "carry",
//     "rollNO": 4,
//     "gs": 33,
//     "hindi2": 67,
//     "english2": 42,
//     "gk": 100
//   },
//   // Add more records here if needed
// ];

// Function to create a new list with subject name and marks
List<Map<String, dynamic>> createSubList(List<Map<String, dynamic>> studentRecords) {
  List<Map<String, dynamic>> subList = [];
  print(studentRecords);

  // Iterate through each student record
  for (var record in studentRecords) {
    // Iterate through the keys in the student record
    record.forEach((key, value) {
      Map<String, dynamic> subjectMarks = {};
      // Exclude testName, addNo, firstName, lastName, and rollNo
      if (key != "testName" && key != "addNo" && key != "firstname" && key != "lastname" && key != "rollNO") {
        subjectMarks["sub"] = key; // Subject name
        subjectMarks["marks"] = value; // Marks
        subList.add(subjectMarks); // Add the object to the new list
      }
    });
  }
  print(subList);
  return subList;
}
