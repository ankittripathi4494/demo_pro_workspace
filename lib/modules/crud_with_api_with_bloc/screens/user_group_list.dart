import 'package:demoproapp/api_list.dart';
import 'package:demoproapp/global_widget/essential_widgets_collection.dart';
import 'package:demoproapp/modules/crud_with_api_with_bloc/model/user_group_resonse_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserGroupList extends StatefulWidget {
  late Map<String, dynamic> args;
  UserGroupList({super.key, required this.args});

  @override
  State<UserGroupList> createState() => _UserGroupListState();
}

class _UserGroupListState extends State<UserGroupList> {
  final String token = 'bnbuujn';
  final String userId = '275';
  final String businessId = '12';

  late List<UserGroupResonseData> userGroupList = [];

  @override
  void initState() {
    super.initState();
    fetchUserGroupList();
  }

  fetchUserGroupList() async {
    var map = {};
    map['token'] = token;
    map['user_id'] = userId;
    map['business_id'] = businessId;
    http.Response responseData = await http
        .post(Uri.http(APIList.mainDomain, APIList.groupList), body: map);

    print("Response Status Code:- ${responseData.statusCode}");
    print("Response Body:- ${responseData.body}");

    try {
      if (responseData.statusCode == 200) {
        var jsonDecode = convert.jsonDecode(responseData.body);

        UserGroupResonseModel userGroupResonseModel =
            UserGroupResonseModel.fromJson(jsonDecode);

        print(jsonDecode.runtimeType);
        if (userGroupResonseModel.response == "success") {
          setState(() {
            userGroupList = userGroupResonseModel.data!;
          });
          EssentialWidgetsCollection.showSuccessSnackbar(
              context, userGroupResonseModel.message!);
        } else {
          EssentialWidgetsCollection.showErrorSnackbar(
              context, userGroupResonseModel.message!);
        }
      } else {
        EssentialWidgetsCollection.showErrorSnackbar(
            context, "Request failed with Status ${responseData.statusCode}");
      }
    } on Exception catch (e) {
      EssentialWidgetsCollection.showErrorSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.args.containsKey('title'))
            ? Text(widget.args['title'])
            : Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/crudApi/read',
                    arguments: widget.args);
              },
              icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: userGroupList.length,
        itemBuilder: (context, index) {
          UserGroupResonseData userGroup = userGroupList[index];
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Colors.deepOrange,Colors.white])
              ),
              child: ListTile(
                title: Text(userGroup.name!),
              ),
            ),
          );
        },
      ),
    );
  }
}
