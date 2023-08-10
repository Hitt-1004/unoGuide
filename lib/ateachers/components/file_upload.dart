import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
// package for for media type
import 'package:http_parser/http_parser.dart';
import '../../common/config/shared-services.dart';
import '../../common/constants/constants.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String action = "";
  String? dropdownValue;
  File? file;
  bool isLoading = false;
  bool showTestToDelete = false;
  List testList = [];
  String testName = "No";
  List<String> names = ['No'];
  String? selectedTestId;
  @override
  void initState() {
    super.initState();
    //get marksheet list
  }

  void selectMarksheet() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );
      if (result == null) return;
      final path = result.files.first.path!;
      final newFile = await saveFile(result.files.first);
      print("path: ${result.files.first.path}");
      print("newFile: ${newFile.path}");

      uploadMarksheet(path);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("file picker error: $e");
    }
  }

  void uploadMarksheet(String path) async {
    Map<String, String> body = {
      "classId": "641457e9cdcadbe836728f1f",
      "id": "63275848690ac78efd493fcd",
      "testName": "Test 77"
    };
    String token = await getTokenFromGlobal();
    Map<String, String> headers = <String, String>{
      "Authorization": "Bearer $token"
    };

    final uri = Uri.parse('$baseURL/teacher/upload-records');

    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile(
        'excel', File(path).readAsBytes().asStream(), File(path).lengthSync(),
        contentType: MediaType('application',
            'vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
        filename: path.split("/").last));
    var response = await request.send();
//    final response = await http.post(uri, body: body, headers: headers);
    print(response);
    print("response: ${response.statusCode}");

    var resData = await response.stream.toBytes();

    var res = String.fromCharCodes(resData);
    print("res: ${resData}");
  }

  Future<File> saveFile(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }

  void deleteMarksheet(String id) async {
    if (testName == "No") return;
    List testNames = testList.map((e) => e["studentRecords"]).toList();

    List testId = testList.map((e) => e["_id"]).toList();
    int selectedIndex = 0;

    if (testId.isNotEmpty && testName != "No") {
      for (var element in testNames) {
        if (element[0]["testName"] == testName) {
          setState(() {
            selectedIndex = testNames.indexOf(element) + 1;
          });
          break;
        } else {}
      }

      if (selectedIndex > 0) {
        setState(() {
          selectedTestId = testId[selectedIndex - 1]!.toString();
        });
      }
    }

    final uri = await Uri.parse(
        "https://backend.unoguide.in/teacher/record?testId=$selectedTestId");

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Test deleted successfully");
      setState(() {
        names.removeAt(names.indexOf(testName));
        testName = "No";
      });
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  void getMarksheetList(String classId, String schoolId) async {
    Map<String, String> headers = <String, String>{};

    getTokenFromGlobal().then((value) => {
          headers["Authorization"] = "Bearer $value",
        });
    final uri = Uri.parse(
      "https://backend.unoguide.in/teacher/records",
    );
    final response = await http.post(uri, body: {
      "classId": classId,
      "id": schoolId,
    });
    setState(() {
      testList = jsonDecode(response.body);
    });
    List testNames = testList.map((e) => e["studentRecords"]).toList();

    // testNames is an array of array
    if (testNames.isNotEmpty) {
      testNames.forEach((element) {
        if (names.contains(element[0]["testName"])) {
          return;
        }
        names.add(element[0]["testName"]);
      });
    }

    setState(() {
      names = names;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherClassProvider>(context);
    //testList = testList.where((e) => e["testName"] != null).toList();

    print("Names: ${names}");
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(top: size.height * 0.15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Marksheet",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 24),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: "upload",
                        groupValue: action,
                        onChanged: (value) {
                          setState(() {
                            action = value.toString();
                            showTestToDelete = false;
                          });
                        }),
                    const Text(
                      "Upload Marksheet",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: "delete",
                        groupValue: action,
                        onChanged: (value) {
                          setState(() {
                            action = value.toString();
                          });
                        }),
                    const Text(
                      "Delete Marksheet",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width * 0.13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.centerEnd,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10),
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                  if (action == "delete" && dropdownValue != "Select Class") {
                    print("classId provider: ${provider.classId}");
                    print("schoolId provider: ${provider.schoolId}");
                    getMarksheetList(provider.classId, provider.schoolId);
                    showTestToDelete = true;
                  }
                },
                items: provider.classes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Visibility(
                visible: action == "upload",
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    selectMarksheet();
                  },
                  child: const Text(
                    'Upload',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
            Visibility(
              visible: showTestToDelete,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                width: size.width * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.centerEnd,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10),
                  value: testName,
                  underline: Container(
                    height: 0,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      testName = value!;
                    });
                  },
                  items: names.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Visibility(
              visible: action == "delete" && testName != "Select Test",
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // deleteMarksheet();

                  deleteMarksheet(selectedTestId.toString());
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
