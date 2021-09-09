import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundary_wender_application/userListWidget/upperBar.dart';
import 'package:laundary_wender_application/userListWidget/userCard.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Users",
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          UpperBar(
              girls: girls,
              boys: boys,
              setBoys: () {
                setState(() {
                  boys = true;
                  girls = false;
                });
              },
              setGirls: () {
                setState(() {
                  boys = false;
                  girls = true;
                });
              }),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy("username")
                    .snapshots(),
                builder: (context, userSnapshot) {
                  return userSnapshot.hasData
                      ? ListView.builder(
                          itemCount: userSnapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot _userData = index == 0
                                ? userSnapshot.data.documents[index]
                                : userSnapshot.data.documents[index - 1];

                            DocumentSnapshot userData =
                                userSnapshot.data.documents[index];
                            if (userData
                                    .data()['laundryBagNo']
                                    .toString()
                                    .startsWith('B-') &&
                                boys) {
                              username = userData.data()['username'];
                              _username = index == 0
                                  ? userData.data()['username']
                                  : _userData.data()['username'];
                              currentHeader = username.substring(0, 1);
                              header = index == 0
                                  ? username.substring(0, 1)
                                  : _username.substring(0, 1);
                              if (index == 0 || index == 0
                                  ? true
                                  : (header != currentHeader)) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 30, top: 10, bottom: 10),
                                        child: Text(
                                          currentHeader,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    UserCard(
                                        userId: userData.data()['userId'],
                                        userEmail: userData.data()['email'],
                                        userName: userData.data()['username'],
                                        userLaundryBagNo:
                                            userData.data()['laundryBagNo'],
                                        userImageUrl:
                                            userData.data()['image_url'])
                                  ],
                                );
                              } else {
                                return UserCard(
                                    userId: userData.data()['userId'],
                                    userEmail: userData.data()['email'],
                                    userName: userData.data()['username'],
                                    userLaundryBagNo:
                                        userData.data()['laundryBagNo'],
                                    userImageUrl: userData.data()['image_url']);
                              }
                            } else if (userData
                                    .data()['laundryBagNo']
                                    .toString()
                                    .startsWith('G-') &&
                                girls)
                              return UserCard(
                                  userId: userData.data()['userId'],
                                  userEmail: userData.data()['email'],
                                  userName: userData.data()['username'],
                                  userLaundryBagNo:
                                      userData.data()['laundryBagNo'],
                                  userImageUrl: userData.data()['image_url']);
                            else
                              return SizedBox();
                          })
                      : CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool boys = true, girls = false;
String header;
String username;
String _username;
String currentHeader;
