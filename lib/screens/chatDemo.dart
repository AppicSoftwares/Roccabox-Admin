import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatDemo extends StatefulWidget {
  const ChatDemo({Key? key}) : super(key: key);

  @override
  _ChatDemoState createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Center(
            child: Text(
              "Chat Demo",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 60, top: 10),
              child: ListView.builder(
                 shrinkWrap: true,
              controller: _controller,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF8F7F7),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Hi, how are you?'),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                                color: Color(0xffF1F0EE),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Good, how are you?'),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
      // height: 50,
                          width: MediaQuery.of(context).size.width * .70,
                          child: TextField(
                            cursorColor: Color(0xff818181),
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Type a message',
                                suffixIcon: Transform.rotate(
                                    angle: 180,
                                    child: Icon(
                                      Icons.attachment,
                                      size: 30,
                                      color: Color(0xff818181),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Color(0xffFFBA00))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffE5E5E5)),
                                    borderRadius: BorderRadius.circular(50)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffFFBA00)),
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffFFBA00)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
