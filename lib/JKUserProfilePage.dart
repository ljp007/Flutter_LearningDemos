import 'package:flutter/material.dart';
import 'package:flutter_testproc/JKUserModel.dart';
import 'package:flutter_testproc/JKUserDataManger.dart';


class JKUserProfilePage extends StatefulWidget {

  const JKUserProfilePage();

  @override
  JKUserProfilePageState createState() => JKUserProfilePageState();

}

class JKUserProfilePageState extends State<JKUserProfilePage> implements JKUserDataOberser {
  final JKUserDataManger _subject = JKUserDataManger();
  List<JKUserModel> _userData = [];

  @override
  void initState() {
    super.initState();
    _subject.addObserver(this); // 注册为观察者
    _subject.fetchUserData();   // 触发数据请求
  }

  @override
  void dispose() {
    _subject.removeObserver(this); // 移除观察者
    super.dispose();
  }

  // 观察者更新方法
  @override
  void update(List<JKUserModel> userData) {
    setState(() {
      _userData = userData; // 更新数据并刷新UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: _userData == null
            ? CircularProgressIndicator()
            : ListView.builder(
              itemCount: _userData.length,
              itemBuilder: (context, index) {
                final JKUserModel user = _userData[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('Age: ${user.age}'),
                );
              },
            ),
      ),
    );
  }
}