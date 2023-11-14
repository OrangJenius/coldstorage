import 'dart:convert';

import 'package:driver_cold_storage/screens/changepass.dart';
import 'package:driver_cold_storage/screens/historyPengawas.dart';
import 'package:driver_cold_storage/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history.dart';
import 'package:driver_cold_storage/models/ProfileModel.dart';
import 'package:http/http.dart' as http;
import 'report.dart';

class profilePengawasScreen extends StatefulWidget {
  final String id;

  const profilePengawasScreen({super.key, required this.id});
  @override
  _profilePengawasScreenState createState() => _profilePengawasScreenState();
}

class _profilePengawasScreenState extends State<profilePengawasScreen> {
  List<ProfileModel> profileData = [];

  Future<List<ProfileModel>> getProfile() async {
    final apiUrl = 'http://116.68.252.201:1945/ProfileUser/${widget.id}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successfully fetched data from the API
        // Parse the response body (JSON), which should be a Map<String, dynamic>
        Map<String, dynamic> apiResponse = jsonDecode(response.body);

        //print(apiResponse); // Print the API response to check the data format

        // Assuming that the API response contains a key called 'users' that holds the list of users
        List<dynamic> userList = apiResponse['data'];

        //print(userList);

        // Convert each item in the list to a UserModel instance using the factory method
        List<ProfileModel> profiles = (userList as List)
            .map((json) => ProfileModel.fromJson(json))
            .toList();

        return profiles;
      } else {
        // API call failed or returned an error status code
        print('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Error occurred during API call
      print('Error: $e');
      return [];
    }
  }

  // void isiData() async {
  //   profileData = await getProfile();
  //   print(
  //     profileData.isNotEmpty ? profileData[0].name : "",
  //   );
  //   print(
  //     profileData.isNotEmpty ? profileData[0].Email : "",
  //   );
  //   print(
  //     profileData.isNotEmpty ? profileData[0].nomor_telpon : "",
  //   );
  //   print(
  //     profileData.isNotEmpty ? profileData[0].Role : "",
  //   );
  //   print(
  //     profileData.isNotEmpty ? profileData[0].id : "",
  //   );
  // }

  void _logout() async {
    // Hapus status login dan data terkait lainnya dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('userID');
    prefs.remove('role');
    print("Hapus prefs");

    // Navigate to the Login screen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, // Pop all routes until the login screen
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    _fetchData(); // Call an async function to fetch data
  }

  Future<void> _fetchData() async {
    await isiData();
    setState(() {}); // Trigger widget rebuild when data is available
  }

  Future<void> isiData() async {
    profileData = await getProfile();
    print(
      profileData.isNotEmpty ? profileData[0].name : "",
    );
    print(
      profileData.isNotEmpty ? profileData[0].Email : "",
    );
    print(
      profileData.isNotEmpty ? profileData[0].nomor_telpon : "",
    );
    print(
      profileData.isNotEmpty ? profileData[0].Role : "",
    );
    print(
      profileData.isNotEmpty ? profileData[0].id : "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Color(0xFF6AD6F9),
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                height: 1, // Atur tinggi garis sesuai kebutuhan
                color: Color(0xFFd9d9d9), // Atur warna garis sesuai kebutuhan
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28, left: 48, right: 48),
                  child: Transform.scale(
                    scale: 2.5, // Ubah faktor skala sesuai keinginan Anda
                    child: CircleAvatar(
                      child: Icon(
                        Icons.image,
                      ), // Ganti dengan thumbnail Anda
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileData.isNotEmpty ? profileData[0].name : "",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 24,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000)),
                        ),
                        Text(
                          profileData.isNotEmpty ? profileData[0].Email : "",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff929292)),
                        ),
                        Text(
                          profileData.isNotEmpty
                              ? profileData[0].nomor_telpon
                              : "",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff929292)),
                        ),
                        Text(
                          "Role: ${profileData.isNotEmpty ? profileData[0].Role : ""}",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff929292)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 8, bottom: 64),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: Color(0xff6AD6F9),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            InkWell(
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => change_pass(
                          email: profileData.isNotEmpty
                              ? profileData[0].Email
                              : "",
                          role:
                              profileData.isNotEmpty ? profileData[0].Role : "",
                        ))),
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline_rounded),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff929292),
                      ),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            InkWell(
              onTap: () {
                // Add your desired functionality when the button is pressed
                _logout();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff929292),
                      ),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
