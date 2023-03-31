// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  String? uid;
  Comments({super.key, required this.uid});

  @override
  State<Comments> createState() => _CommentsState(uid);
}

class _CommentsState extends State<Comments> {
  String? uid;
  _CommentsState(this.uid);
  bool isvisible = false;
  TextEditingController commentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "Comments",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('user')
                  .collection('Community Engagement')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                print(data['comments']);
                if (data['comments'].length == 0) {
                  return Center(
                    child: Text('No comments Yet'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data['comments'].length,
                  itemBuilder: (context, index) => CustomNewComment(
                      context,
                      data['comments'][index]['comment'],
                      data['comments'][index]['time'].toDate()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            onChanged: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  isvisible = false;
                });
              } else {
                setState(() {
                  isvisible = true;
                });
              }

              print(isvisible);
            },
            controller: commentcontroller,
            decoration: InputDecoration(
              hintText: "Leave your thoughts here....",
              suffixIcon: Visibility(
                visible: isvisible,
                child: GestureDetector(
                  child: Icon(Icons.send),
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc('user')
                        .collection('Community Engagement')
                        .doc(uid)
                        .set({
                      'comments': FieldValue.arrayUnion([
                        {
                          'comment': commentcontroller.text,
                          'time': DateTime.now()
                        }
                      ])
                    }, SetOptions(merge: true)).whenComplete(() {
                      commentcontroller.clear();
                    });
                  },
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

Widget CustomNewComment(BuildContext context, String comment, DateTime date) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(6),
        bottomRight: Radius.circular(6),
        bottomLeft: Radius.circular(6),
      ),
      color: Color.fromARGB(255, 246, 243, 243),
    ),
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
    child: ListTile(
      title: Text(comment),
      trailing: Text(
        timeago.format(date),
      ),
    ),
  );
}
