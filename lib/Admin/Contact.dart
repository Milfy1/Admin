import 'dart:convert';
import 'dart:io';
import 'package:Admin/Styles.dart';
import 'package:Admin/models/profile_model.dart';
import 'package:Admin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendEmail extends StatefulWidget {
  final ProfileModel user;
  const SendEmail({Key? key, required this.user}) : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  String? message;
  String? subject;
  //Send Email Method
  Future sendEmail({
    required String subject,
    required String message,
    required String name,
    required String email,
  }) async {
    final serviceId = 'service_esjrub6';
    final templateId = 'template_gpdnxtx';
    final userId = 'wRl-gztCaHY5z6ghO';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
    print(response.body);
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
        backgroundColor: colors.blue_base,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                Container(
                  child: Text(
                    'Name of reciver: ${widget.user.userName}',
                    style: TextStyle(color: colors.black100, fontSize: 30),
                  ),
                ),
                Container(
                  child: Text(
                    'Email of reciver: ${widget.user.email}',
                    style: TextStyle(color: colors.black100, fontSize: 30),
                  ),
                ),
                Container(
                  child: Text(
                    'Subject:',
                    style: TextStyle(color: colors.black100, fontSize: 30),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  width: 160,
                  child: TextFormField(
                      //   maxLength: 20,
                      style: TextStyle(fontSize: 30),
                      decoration: InputDecoration(
                        hintText: 'Subject',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colors.black100),
                        ),
                      ),
                      onChanged: (value) {
                        subject = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please Write the Subject of the Message';
                      }),
                ),
                Container(
                  child: Text(
                    'Message',
                    style: TextStyle(color: colors.black100, fontSize: 30),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: colors.black100),
                      ),
                    ),
                    maxLines: 6,
                    onChanged: (value) {
                      message = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Message Should Not Be Empty';
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colors.blue_base),
                  child: FlatButton(
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        Navigator.of(context).pop();
                        sendEmail(
                            subject: subject!,
                            message: message!,
                            email: widget.user.email!,
                            name: widget.user.userName!);
                        AppUser.message(context, true, "Email Sent");
                      }
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
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
