import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heath_care/model/district.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/model/village.dart';

import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/NavSideBar.dart';
import 'package:heath_care/utils/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  User _profile = new User();
  String? _selectedGender;
  var _image;
  List<String?> nameList = [];
  List<String> _gender = ["Nam", "Nữ"];
  District? selectedDistrict;
  Village? selectedVillage;
  final df = new DateFormat('dd-MM-yyyy');
  _UserProfileScreenState() {
    UserRepository().getCurrentUserWithoutCache().then((val) => setState(() {
          _profile = val;
        }));
    UserRepository().getCurrentUser().then((val) => setState(() {
          _profile = val;
        }));
  }
  DateTime? _selectedDate;
  TextEditingController _textDOBController = TextEditingController();
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textAddressController = TextEditingController();
  TextEditingController _textIDCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_profile.identityId == null) {
      _textIDCardController.clear();
    } else {
      _textIDCardController.text = _profile.identityId.toString();
    }
    if (_profile.address == null) {
      _textAddressController.clear();
    } else {
      _textAddressController.text = _profile.address.toString();
    }
    _textNameController.text = _profile.getDisplayName();

    if (_profile.firstname == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("HỒ SƠ"),
          ),
          body: Center(child: CircularProgressIndicator()));
    } else {
      _textDOBController
        ..text = df.format(_profile.dateOfBirth!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textDOBController.text.length,
            affinity: TextAffinity.upstream));
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: const Text("HỒ SƠ"),
          ),
          body: ListView(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () async {
                      try {
                        image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 70);
                      } catch (e) {
                        print(e);
                      }
                      if (image != null) {
                        setState(() {
                          _image = File(image!.path).readAsBytesSync();
                        });
                      }
                      List<int> imageBytes =
                          File(image!.path).readAsBytesSync();
                      // final bytes = File(image!.path).readAsBytesSync();

                      if (_image == null) {
                        _showerrorDialog("Xảy ra lỗi");
                      } else {
                        String base64Image = "data:image/jpg;base64,"+base64Encode(_image);
                        print(_image);
                        _profile.avatar = base64Image;
                        Image.memory(_image);
                        var _respone =
                            await UserRepository().updateUser(_profile);
                        print(_respone);
                        if (_respone
                            .toString()
                            .contains("UPDATE_USER_SUCCESS")) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                'Thành Công',
                                style: TextStyle(color: Colors.blue),
                              ),
                              content: Text("Cập nhập thông tin thành công"),
                              actions: <Widget>[
                                // ignore: deprecated_member_use
                                FlatButton(
                                  child: Text('Okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        } else if (_respone
                            .toString()
                            .contains("UPDATE_USER_FAIL")) {
                          _showerrorDialog(
                              "Cập Nhập Thông Tin Không Thành Công");
                        } else {
                          print(_respone);
                          _showerrorDialog("Đã Xảy Ra Lỗi");
                        }
                      }
                    },
                    child: _profile.avatar == null
                     ? CircleAvatar(
                        radius: 50,
                        backgroundImage:
                         AssetImage('assets/images/img_1.png'))
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        NetworkImage( Api.imageUrl + _profile.avatar!)),
                  ),
                ),
              ),

              Center(
                  child: Text(_profile.getDisplayName(),
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500))),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          TextEditingController(text: _textNameController.text),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: (val) {
                        String _surname = "";
                        nameList = val.split(" ");
                        print(val.split(" "));
                        if (nameList.length > 2) {
                          _profile.firstname = nameList.first;
                          for (int i = 1; i < nameList.length - 1; i++) {
                            _surname += (nameList[i]! + " ");
                          }
                          _profile.surname = _surname.trim();

                          _profile.lastname = nameList.last;
                        }
                        if (nameList.length > 1) {
                          _profile.firstname = nameList.first;
                          _profile.lastname = nameList.last;
                        } else {
                          _profile.firstname = val;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Họ và tên (*):",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                decoration: const InputDecoration(
                                    labelText: "Ngày Sinh (*):",
                                    labelStyle: TextStyle(fontSize: 18)),
                                focusNode: AlwaysDisabledFocusNode(),
                                controller: _textDOBController,
                                onTap: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                            Text("Giới tính", style: TextStyle(fontSize: 16)),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DropdownButton<String>(
                                hint: _selectedGender != null
                                    ? Text(
                                        _selectedGender!.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : Text(
                                        _profile.gender.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                items: _gender.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                    _profile.gender = value;
                                  });

                                  ;
                                },
                              ),
                            ),
                          ],
                        )),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(text: _profile.phone),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Số Điện Thoại (*):",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      controller: _textIDCardController,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: (val) {
                        _profile.identityId = val;
                      },
                      decoration: const InputDecoration(
                          labelText: "Căn Cước công dân/ hộ chiếu (*):",
                          hintText: "Vui Lòng Cập Nhập",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(
                          text: _profile.province!.name.toString()),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Thành phố:",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(
                        text: _profile.district!.name.toString(),
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Quận/Huyện:",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: TextEditingController(
                          text: _profile.village!.name.toString()),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Làng/xã:",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      controller: _textAddressController,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      onChanged: (val) {
                        _profile.address = val;
                      },
                      decoration: const InputDecoration(
                          labelText: "Địa chỉ thường trú (*):",
                          hintText: "Vui Lòng Cập Nhập",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: 130.0,
                                height: 40.0,
                                // ignore: deprecated_member_use
                                child: new RaisedButton(
                                  color: Color.fromRGBO(78, 159, 193, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  onPressed: () async {
                                    var _respone = await UserRepository()
                                        .updateUser(_profile);
                                    print(_respone);
                                    if (_respone
                                        .toString()
                                        .contains("UPDATE_USER_SUCCESS")) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text(
                                            'Thành Công',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          content: Text(
                                              "Cập nhập thông tin thành công"),
                                          actions: <Widget>[
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              child: Text('Okay'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (_respone
                                        .toString()
                                        .contains("UPDATE_USER_FAIL")) {
                                      _showerrorDialog(
                                          "Cập Nhập Thông Tin Không Thành Công");
                                    } else {
                                      print(_respone);
                                      _showerrorDialog("Đã Xảy Ra Lỗi");
                                    }
                                  },
                                  child: new Text(
                                    'Cập Nhập',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: NavDrawer());
    }
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
    progressImage() {
      final bytes = File(image!.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      if (img64 == null) {
        _showerrorDialog("Xảy ra lỗi");
      } else {}
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _profile.dateOfBirth!,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    _textDOBController
      ..text = df.format(_profile.dateOfBirth!)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: _textDOBController.text.length,
          affinity: TextAffinity.upstream));
    if (picked != null && picked != _profile.dateOfBirth!)
      setState(() {
        _profile.dateOfBirth = picked;
      });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
