// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice360/components/drawer.dart';
import 'package:justice360/login.dart';
import 'package:justice360/women/Community_Engagement/comments.dart';
import 'package:justice360/women/Community_Engagement/post.dart';

class CommunityEngagement extends StatefulWidget {
  const CommunityEngagement({super.key});

  @override
  State<CommunityEngagement> createState() => _CommunityEngagementState();
}

class _CommunityEngagementState extends State<CommunityEngagement> {
  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 243, 243),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "Community Engagement",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('user')
                  .collection('Community Engagement')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Blog(
                        context,
                        snapshot.data!.docs[index]['date'],
                        snapshot.data!.docs[index]['time'],
                        snapshot.data!.docs[index]['crimetag'],
                        snapshot.data!.docs[index]['blog'],
                        snapshot.data!.docs[index]['likes'],
                        snapshot.data!.docs[index]['docid'],
                        snapshot.data!.docs[index]['comments'],
                      );
                    },
                  );
                }
                return const Text("Something went wrong");
              },
            ),
            // Blog(context, DateTime.now(), "Sexual Harassment",
            //     "Stay focused Stay safe", 12, 23, 34),
            // SizedBox(
            //   height: 8,
            // ),
            // Blog(context, DateTime.now(), "Sexual Harassment",
            //     "Stay focused Stay safe", 12, 23, 34),
            // SizedBox(
            //   height: 8,
            // ),
            // Blog(context, DateTime.now(), "Sexual Harassment",
            //     "Stay focused Stay safe", 12, 23, 34),
            // SizedBox(
            //   height: 8,
            // ),
            // Blog(context, DateTime.now(), "Sexual Harassment",
            //     "Stay focused Stay safe", 12, 23, 34),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => Post()),
          ),
        ),
      ),
    );
  }
}

class CustomBlog extends StatelessWidget {
  const CustomBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Blog(BuildContext context, String date, String time, String blog_type,
    String blog, List like, String uid, List comment) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  date.toString(),
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "|",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  time.toString(),
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(
                  Radius.circular(6),
                ),
                color: Colors.teal.shade500,
              ),
              child: Text(
                blog_type,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          blog,
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 16,
                  color: Colors.teal.shade500,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  like.length.toString() + " likes",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  comment.length.toString() + " comments",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          thickness: 1,
          color: Colors.black26,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    like.contains(FirebaseAuth.instance.currentUser!.uid)
                        ? await FirebaseFirestore.instance
                            .collection('users')
                            .doc('user')
                            .collection('Community Engagement')
                            .doc(uid)
                            .update({
                            'likes': FieldValue.arrayRemove(
                                [FirebaseAuth.instance.currentUser!.uid])
                          })
                        : await FirebaseFirestore.instance
                            .collection('users')
                            .doc('user')
                            .collection('Community Engagement')
                            .doc(uid)
                            .update({
                            'likes': FieldValue.arrayUnion(
                                [FirebaseAuth.instance.currentUser!.uid])
                          });
                  },
                  child: Icon(
                    Icons.thumb_up_alt_rounded,
                    color: like.contains(FirebaseAuth.instance.currentUser!.uid)
                        ? Colors.teal.shade500
                        : Colors.black,
                    size: 16,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Like"),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Comments(uid: uid)),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.comment_rounded,
                    size: 16,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Comment"),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
