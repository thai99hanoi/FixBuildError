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
  List<District> _districts = [];
  List<Province> _allProvince = [];
  List<Village> _allVillage = [];
  District? selectedDistrict;
  Village? selectedVillage;
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
  TextEditingController _textPhoneController = TextEditingController();
  TextEditingController _textIDCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_profile.dateOfBirth == null) {
      _textDOBController.text = 'Vui Lòng Cập Nhập Ngày Sinh';
    } else {
      _textDOBController.text = DateFormat.yMd().format(_profile.dateOfBirth!);
    }
    if (_selectedProvince == null) {
      _selectedProvince = _profile.province;
    }
    if (selectedDistrict == null) {
      selectedDistrict = _profile.district;
    }
    if (selectedVillage == null) {
      selectedVillage = _profile.village;
    }

    _selectedGender = _profile.gender;

    if (_profile.firstname == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
            title: Text("Chi Tiết Bài Tập"),
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
                  child: Text(_profile.firstname! +
                      " " +
                      _profile.surname! +
                      " " +
                      _profile.lastname!)),
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
                      controller: TextEditingController(
                          text: _profile.firstname! +
                              " " +
                              _profile.surname! +
                              " " +
                              _profile.lastname!),
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
                                items:
                                    <String>['Nam', 'Nữ'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ],
                        )),
                    TextFormField(
                      controller: TextEditingController(text: _profile.phone),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Số Điện Thoại (*):",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: _profile.identityId.toString()),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Căn Cước công dân/ hộ chiếu (*):",
                          labelStyle: TextStyle(fontSize: 18)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text("Thành Phố:",
                              style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                          child: DropdownButton<Province>(
                              hint: Text(
                                  _selectedProvince?.name ?? 'Vui lòng chọn'),
                              items: _allProvince.map((Province province) {
                                return DropdownMenuItem<Province>(
                                  value: province,
                                  child: Text(province.name!),
                                );
                              }).toList(),
                              onChanged: (province) async {
                                setState(() {
                                  _selectedProvince = province;
                                });
                                AddressRepository()
                                    .getAllDistrictByProvinceId(
                                        province!.provinceId)
                                    .then((vall) => setState(() {
                                          _selectedProvince = province;

                                          _districts = vall!;
                                        }));
                              }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Text("Quận/ Huyện: ",
                              style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                          child: DropdownButton<District>(
                            hint:
                                Text(selectedDistrict?.name ?? 'Vui Lòng Chọn'),
                            items: _districts.map((District district) {
                              return DropdownMenuItem<District>(
                                value: district,
                                child: Text(district.name!),
                              );
                            }).toList(),
                            onChanged: (district) {
                              setState(() {
                                selectedDistrict = district;
                              });
                              AddressRepository()
                                  .getAllVillageByDistrictId(
                                      district!.districtId)
                                  .then((vall) => setState(() {
                                        _allVillage = vall!;
                                        selectedDistrict = district;
                                      }));
                              //tượng tự có districtId, làm tiếp
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Text("Làng/ Xã: ",
                              style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                          child: DropdownButton<Village>(
                            hint:
                                Text(selectedVillage?.name ?? 'Vui Lòng Chọn'),
                            items: _allVillage.map((Village village) {
                              return DropdownMenuItem<Village>(
                                value: village,
                                child: Text(village.name!),
                              );
                            }).toList(),
                            onChanged: (village) {
                              print(village!.villageId);
                              setState(() {
                                selectedVillage = village;
                              });
                              //tượng tự có districtId, làm tiếp
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: _profile.address.toString()),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: "Địa chỉ thường trú (*):",
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
                                    'Huỷ',
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
        ..text = DateFormat.yMd().format(_selectedDate!)
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
