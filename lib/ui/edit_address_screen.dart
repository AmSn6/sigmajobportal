import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sigmajobportal/models/address_model.dart';
import 'package:sigmajobportal/models/district_model.dart';
import 'package:sigmajobportal/models/state_model.dart';
import 'package:sigmajobportal/repository.dart';

import '../utils.dart';

class EditAddressScreen extends StatefulWidget {
  final String addressLine1,
      addressLine2,
      countryName,
      countryID,
      stateName,
      stateID,
      districtName,
      districtID,
      pincode;

  EditAddressScreen(
      {Key key,
      this.addressLine1,
      this.addressLine2,
      this.countryName,
      this.countryID,
      this.stateName,
      this.stateID,
      this.districtName,
      this.districtID,
      this.pincode})
      : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController _address1Cntlr;
  TextEditingController _address2Cntlr;
  TextEditingController _countryNameCntlr;
  TextEditingController _countryIDCntlr;
  TextEditingController _stateNameCntlr;
  TextEditingController _stateIDCntlr;
  TextEditingController _districtNameCntlr;
  TextEditingController _districtIDCntlr;
  TextEditingController _pincodeCntlr;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<District> _districtList = [];

  Future _future;

  @override
  void initState() {
    super.initState();
    _address1Cntlr = new TextEditingController(text: widget.addressLine1);
    _address2Cntlr = new TextEditingController(text: widget.addressLine2);
    _countryNameCntlr = new TextEditingController(text: widget.countryName);
    _countryIDCntlr = new TextEditingController(text: widget.countryID);
    _stateNameCntlr = new TextEditingController(text: widget.stateName);
    _stateIDCntlr = new TextEditingController(text: widget.stateID);
    _districtNameCntlr = new TextEditingController(text: widget.districtName);
    _districtIDCntlr = new TextEditingController(text: widget.districtID);
    _pincodeCntlr = new TextEditingController(text: widget.pincode);

    _future = getStateList();

  }

  @override
  void dispose() {
    _address1Cntlr.dispose();
    _address2Cntlr.dispose();
    _countryNameCntlr.dispose();
    _countryIDCntlr.dispose();
    _stateNameCntlr.dispose();
    _stateIDCntlr.dispose();
    _districtNameCntlr.dispose();
    _districtIDCntlr.dispose();
    _pincodeCntlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: appbarMethod('Edit address'),
      body: FutureBuilder<StateModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('error - ${snapshot.error}');
              return errorWidget(context);
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            h1Text('Address Line 1'),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: _address1Cntlr,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Enter Address Line 1';
                                  }
                                },
                                onSaved: (val) {
                                  _address1Cntlr.text = val;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Address Line 1',
                                    hintStyle: TextStyle(
                                      color: grey1,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            h1Text('Address Line 2'),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: _address2Cntlr,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Enter Address Line 2';
                                  }
                                },
                                onSaved: (val) {
                                  _address2Cntlr.text = val;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Address Line 2',
                                    hintStyle: TextStyle(color: grey1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
//                Container(
//                  width: double.infinity,
//                  padding: EdgeInsets.all(10),
//                  decoration: BoxDecoration(
//                    color: white,
//                    borderRadius: BorderRadius.circular(5),
//                  ),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      h1Text('Country'),
//                      SizedBox(
//                        height: 15,
//                      ),
//                      Container(
//                        padding: EdgeInsets.only(left: 12),
//                        decoration: BoxDecoration(
//                            color: grey,
//                            borderRadius: BorderRadius.circular(30)),
//                        child: TextFormField(
//                          decoration: InputDecoration(
//                              border: InputBorder.none,
//                              suffixIcon: Icon(FeatherIcons.chevronDown),
//                              hintText: 'Country',
//                              hintStyle: TextStyle(color: grey1)),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            h1Text('State'),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TypeAheadFormField<StateList>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _stateNameCntlr,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon:
                                          Icon(FeatherIcons.chevronDown),
                                      hintText: 'State',
                                      hintStyle: TextStyle(color: grey1)),
                                ),
                                autoFlipDirection: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Select State';
                                  }
                                },
                                onSuggestionSelected: (degree) async {
                                  _stateIDCntlr.text = degree.stateId;
                                  _stateNameCntlr.text = degree.stateName;

                                  DistrictModel model = await getDistrictList({
                                    'state_id': _stateIDCntlr.text,
                                  });
                                  _districtList = model.district;
                                },
                                itemBuilder: (context, degree) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(degree.stateName),
                                  );
                                },
                                getImmediateSuggestions: true,
                                suggestionsCallback: (pattern) {
                                  return snapshot.data.stateList
                                      .where((val) => val.stateName
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()))
                                      .toList();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            h1Text('District'),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TypeAheadFormField<District>(
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _districtNameCntlr,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(FeatherIcons.chevronDown),
                                      hintText: 'District',
                                      hintStyle: TextStyle(color: grey1)),
                                ),
                                autoFlipDirection: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Select District';
                                  }
                                },
                                onSuggestionSelected: (degree) async {
                                  _districtIDCntlr.text = degree.districtId;
                                  _districtNameCntlr.text = degree.districtName;
                                },
                                itemBuilder: (context, degree) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(degree.districtName),
                                  );
                                },
                                getImmediateSuggestions: true,
                                suggestionsCallback: (pattern) {
                                  return _districtList
                                      .where((val) => val.districtName
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()))
                                      .toList();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            h1Text('Pincode'),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                controller: _pincodeCntlr,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Enter Pincode';
                                  }
                                },
                                onSaved: (val) {
                                  _pincodeCntlr.text = val;
                                },
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Pincode',
                                    hintStyle: TextStyle(color: grey1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: RaisedButton(
                          shape: buttonShape(30),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              editAddress();
                            }
                          },
                          color: purple,
                          child: buttonText('Edit address'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void editAddress() {
    Navigator.pop(
        context,
        AddressModel(
          addressLine1: _address1Cntlr.text,
          addressLine2: _address2Cntlr.text,
          countryName: _countryNameCntlr.text,
          countryID: _countryIDCntlr.text,
          stateName: _stateNameCntlr.text,
          stateID: _stateIDCntlr.text,
          districtName: _districtNameCntlr.text,
          districtID: _districtIDCntlr.text,
          pincode: _pincodeCntlr.text,
        ));
  }
}
