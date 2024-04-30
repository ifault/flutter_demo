import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/model/accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddAccountDialog extends GetView<AccountController> {
  const AddAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();

    return AlertDialog(
      title: Text('添加账号'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(hintText: '输入账号名'),
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            // 处理结束按钮点击事件
            Navigator.of(context).pop(); // 关闭弹框
          },
          child: Text('结束'),
        ),
        CupertinoButton(
          onPressed: () {
            // 处理确认按钮点击事件

            String enteredText = _textEditingController.text;
            if(enteredText == ""){
              EasyLoading.showError("账号不能为空");
              return;
            }
            EasyLoading.show(status: '等待中...');
            controller.addAccount(enteredText).then((value){
                EasyLoading.dismiss();

            });
            Navigator.of(context).pop();
             // 关闭弹框
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}
class BindGALDialog extends GetView<AccountController> {
  const BindGALDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = "GAL";
    return AlertDialog(
      title: Text('绑定早享卡（未完成此功能）'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(hintText: '输入早享卡号'),
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('结束'),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}
class DeleteDialog extends GetView<AccountController> {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('删除当前账号'),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
        CupertinoButton(
          onPressed: () {
            // EasyLoading.show(status: '等待中...');
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}
class AddToWaitingDialog extends GetView<AccountController> {
  const AddToWaitingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('加入抢票列表'),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
        CupertinoButton(
          onPressed: () {
            // EasyLoading.show(status: '等待中...');
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}
class BackToFreeDialog extends GetView<AccountController> {
  const BackToFreeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('撤回到闲置列表'),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
        CupertinoButton(
          onPressed: () {
            // EasyLoading.show(status: '等待中...');
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}



class DeleteBatchDialog extends GetView<AccountController> {
  String content;
  int status;
  DeleteBatchDialog({super.key, required this.content, required this.status});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
        CupertinoButton(
          onPressed: () {
            // EasyLoading.show(status: '等待中...');
            Navigator.of(context).pop();
          },
          child: Text('确认'),
        ),
      ],
    );
  }
}