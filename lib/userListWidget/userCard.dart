import 'package:flutter/material.dart';
import 'package:laundary_wender_application/userOrderPage.dart';

class UserCard extends StatelessWidget {
  final String userImageUrl;
  final String userLaundryBagNo;
  final String userName;
  final String userEmail;
  final String userId;

  UserCard({
    @required this.userEmail,
    @required this.userName,
    @required this.userId,
    @required this.userLaundryBagNo,
    @required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return UserOrderPage(
            userId: userId,
          );
        }));
      },
      child: Card(
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userImageUrl),
                  radius: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userLaundryBagNo,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
