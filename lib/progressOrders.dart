import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundary_wender_application/constraints.dart';
import 'package:laundary_wender_application/orderDetails.dart';
import 'package:laundary_wender_application/richText.dart';

class ProgressOrders extends StatelessWidget {
  final String userId;

  ProgressOrders({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(userId)
            .collection('user_orders')
            .snapshots(),
        builder: (context, orderSnapshot) {
          return orderSnapshot.hasData
              ? ListView.builder(
                  itemCount: orderSnapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot orderData =
                        orderSnapshot.data.documents[index];

                    return orderData.data()['order_accepted'] &&
                            !orderData.data()['order_processing']
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          orderData.data()['laundryBagNo'],
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              orderData.data()['orderId'],
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              orderData.data()['User Details']
                                                  ['image_url']),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              title1: 'NAME',
                                              title2: orderData
                                                      .data()['User Details']
                                                  ['username'],
                                            ),
                                            CustomText(
                                              title1: "E-MAIL",
                                              title2: orderData
                                                      .data()['User Details']
                                                  ['email'],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      title1: 'DATE & TIME',
                                      title2:
                                          "${orderData.data()['Date & Time']['day']}, ${orderData.data()['Date & Time']['date']}, ${orderData.data()['Date & Time']['time']}",
                                    ),
                                    CustomText(
                                      title1: 'TOTAL CLOTHS',
                                      title2: orderData
                                          .data()['total cloths']
                                          .toString(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return OrderDetails(
                                                userId: userId,
                                                orderId:
                                                    orderData.data()['orderId'],
                                              );
                                            }));
                                          },
                                          child: Container(
                                            width: width(context) * 0.42,
                                            height: 40,
                                            child: Center(
                                                child: Text(
                                              "VIEW DETAILS",
                                              style: GoogleFonts.lato(
                                                  color: Colors.orange),
                                            )),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.orange),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(userId)
                                                .collection('user_orders')
                                                .doc(orderData.id)
                                                .update(
                                                    {'order_processing': true});
                                          },
                                          child: Container(
                                            width: width(context) * 0.42,
                                            height: 40,
                                            child: Center(
                                                child: Text(
                                              "PROCESSED",
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
                                            )),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
                  },
                )
              : CircularProgressIndicator();
        });
  }
}
