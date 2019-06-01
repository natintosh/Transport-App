import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTripDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trip Details'),
      ),
      body: _MyTripDetailsContent(),
    );
  }
}

class _MyTripDetailsContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTripDetailsContentState();
  }
}

class _MyTripDetailsContentState extends State<_MyTripDetailsContent> {
  DateTime dateOfBirth = DateTime.now();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nextOfKinController = TextEditingController();
  TextEditingController _nextOfKinPhoneNumberController =
      TextEditingController();

  void _setDateOfBirth(DateTime date) {
    dateOfBirth = date;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'First Name',
              controller: _firstNameController,
            ),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Last Name',
              controller: _lastNameController,
            ),
            _DetailCalenderWidget(
                key: UniqueKey(),
                title: 'Date of Birth',
                onDateChanged: _setDateOfBirth),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Phone Number',
              controller: _phoneNumberController,
              textInputType: TextInputType.phone,
            ),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Address',
              controller: _addressController,
            ),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Next of Kin',
              controller: _nextOfKinController,
            ),
            _DetailTextFieldWidget(
              key: UniqueKey(),
              title: 'Next of Kin Phone Number',
              controller: _nextOfKinPhoneNumberController,
              textInputType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailTextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType textInputType;
  const _DetailTextFieldWidget(
      {Key key,
      @required this.title,
      @required this.controller,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailTextFieldWidgetState();
  }
}

class _DetailTextFieldWidgetState extends State<_DetailTextFieldWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.title}',
              style: Theme.of(context).textTheme.body1,
            ),
            TextField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
            )
          ]),
    );
  }
}

class _DetailCalenderWidget extends StatefulWidget {
  final String title;
  final ValueChanged<DateTime> onDateChanged;

  const _DetailCalenderWidget(
      {Key key, @required this.title, @required this.onDateChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailCalenderWidgetState();
  }
}

class _DetailCalenderWidgetState extends State<_DetailCalenderWidget> {
  DateTime selectedDate = DateTime.now();

  void _setSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      widget.onDateChanged(date);
    });
  }

  String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEEE, d  MMMM y');
    String format = formatter.format(date);
    return format;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2120));

    if (pickedDate != null) {
      _setSelectedDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(getFormattedDate(selectedDate)),
                IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => _selectDate(context))
              ],
            )
          ]),
    );
  }
}
