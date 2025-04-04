// 观察者接口
import 'package:flutter_testproc/JKUserModel.dart';

abstract class JKUserDataOberser {
  void update(List<JKUserModel> userData);
}

abstract class JKUserDataService{
    Future<void> fetchUserData();
}

// 主题（被观察者） 
class JKUserDataManger implements JKUserDataService {
  final List<JKUserDataOberser> _observers = [];
  final List<JKUserModel> _userData = [];

  void addObserver(JKUserDataOberser observer) {
    _observers.add(observer);
  }

  void removeObserver(JKUserDataOberser observer) {
    _observers.remove(observer);
  }

  void _notifyObservers() {
    for (var observer in _observers) {
      observer.update(_userData!);
    }
  }

  // 模拟异步请求数据 service
  @override
  Future<void> fetchUserData() async {
    await Future.delayed(Duration(seconds: 2)); // 模拟网络延迟
    
    JKUserModel user1 = JKUserModel("Tome", 10);
    JKUserModel user2 = JKUserModel("jj", 20);
    JKUserModel user3 = JKUserModel("Jac", 19);
    _userData.add(user1);
    _userData.add(user2);
    _userData.add(user3);

    _notifyObservers(); // 通知所有观察者
  }
}