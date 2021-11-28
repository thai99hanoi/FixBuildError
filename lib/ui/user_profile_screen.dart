import 'package:flutter/material.dart';
import 'package:heath_care/model/district.dart';
import 'package:heath_care/model/province.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/model/village.dart';
import 'package:heath_care/repository/address_repository.dart';

import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/NavSideBar.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User _profile = new User();
  String? _selectedGender;
  List<String> _gender = ["Nam", "Nữ"];
  List<District> _districts = [];
  List<Province> _allProvince = [];
  List<Village> _allVillage = [];
  District? selectedDistrict;
  Village? selectedVillage;
  final df = new DateFormat('dd-MM-yyyy');
  _UserProfileScreenState() {
    UserRepository().getCurrentUser().then((val) => setState(() {
          _profile = val;
        }));
    AddressRepository().getAllProvince().then((vall) => setState(() {
          _allProvince = vall;
        }));
  }
  Province? _selectedProvince;
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
    _selectedDate = _profile.dateOfBirth;
    if (_profile.dateOfBirth == null) {
      _textDOBController.text = 'Vui Lòng Cập Nhập Ngày Sinh';
    } else {
      _selectedDate = _profile.dateOfBirth;
      _textDOBController.text = df.format(_profile.dateOfBirth!);
    }
    _selectedGender = _profile.gender;

    if (_profile.firstname == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("HỒ SƠ"),
          ),
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: const Text("HỒ SƠ"),
          ),
          body: ListView(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/img_1.png')),
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
                                hint: Text(
                                    _selectedGender ??
                                        'Vui Lòng Chọn Giới Tính',
                                    style: TextStyle(fontSize: 12)),
                                items: _gender.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _selectedGender = value;
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
                                  onPressed: () {},
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

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textDOBController
        ..text = df.format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textDOBController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
