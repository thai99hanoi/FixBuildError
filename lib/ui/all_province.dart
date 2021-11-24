import 'package:flutter/material.dart';
import 'package:heath_care/model/province.dart';
import 'package:heath_care/repository/address_repository.dart';

class AllProvinceDropdown extends StatefulWidget {
  const AllProvinceDropdown({Key? key}) : super(key: key);

  @override
  _AllProvinceDropdownState createState() => _AllProvinceDropdownState();
}

class _AllProvinceDropdownState extends State<AllProvinceDropdown> {
  late List<Province> _allProvince;
  _AllProvinceDropdownState() {
    AddressRepository().getAllProvince().then((vall) => setState(() {
          _allProvince = vall;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: _allProvince
          .map(
            (map) => DropdownMenuItem(
              child: Text(map.name!),
              value: map.provinceId,
            ),
          )
          .toList(),
    );
  }
}
