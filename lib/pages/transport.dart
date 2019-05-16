import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransportPageContent();
  }
}

class TransportPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransportPageContentState();
  }
}

class _TransportPageContentState extends State<TransportPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text("MNT Transport",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed(<Widget>[
              _TransportDetailsCard(
                  details:
                      "Best Transport in Africa, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut vestibulum eros, vel elementum nisi. Donec dolor magna, euismod sit amet mi et, rhoncus vulputate lectus. Curabitur placerat condimentum mi."),
              _TransportDestinationCard(destination: <String>[]),
              _TransportBookTicket(),
            ]))
          ],
        ),
      ),
    );
  }
}

class _TransportDetailsCard extends StatelessWidget {
  final String details;
  _TransportDetailsCard({@required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Details",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
              Text(details)
            ],
          ),
        ),
      ),
    );
  }
}

class _TransportDestinationCard extends StatelessWidget {
  final List<String> destination;
  _TransportDestinationCard({@required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Destinations",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10.0,
                children: <Widget>[
                  Chip(label: Text("Lagos")),
                  Chip(label: Text("Enugu")),
                  Chip(label: Text("Kaduna")),
                  Chip(label: Text("Abuja")),
                  Chip(label: Text("Ibadan")),
                  Chip(label: Text("Benin")),
                  Chip(label: Text("Calabar")),
                  Chip(label: Text("Ogun")),
                  Chip(label: Text("Delta")),
                  Chip(label: Text("Edo")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransportBookTicket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransportBookTicketState();
  }
}

class _TransportBookTicketState extends State<_TransportBookTicket> {
  bool isOneWay = true;
  String departureValue;
  String destinationValue;
  DateTime departureDate;
  DateTime arrivalDate;

  void _setDepartureDate(DateTime date) {
    departureDate = date;
    print("departure $date");
  }

  void _setArrivalDate(DateTime date) {
    arrivalDate = date;
    print("arrival $date");
  }

  void _setDepartureValue(String value) {
    setState(() {
      departureValue = value;
    });
  }

  void _setDestinationValue(String value) {
    setState(() {
      destinationValue = value;
    });
  }

  void _setTrip() {
    setState(() {
      isOneWay = !isOneWay;
    });
  }

  void _bookTrip() {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Book Trip")));
  }

  List<String> _getDestination() {
    List<String> destination = [
      "Lagos",
      "Abuja",
      "Enugu",
      "Ibadan",
      "Imo",
      "Benin",
      "Calabar",
      "Ogun",
      "Delta",
      "Edo",
    ];

    return destination;
  }

  List<String> _getQuantity() {
    List<String> quantityList =
        List.generate(13, (int index) => (index + 1).toString());
    return quantityList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Book Trip",
                style: TextStyle(fontSize: 18.0),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(8),
                child: isOneWay
                    ? _BookTripOneTrip(
                        key: UniqueKey(),
                        isOneWay: isOneWay,
                        departureValue: departureValue,
                        destinationValue: destinationValue,
                        departureDate: departureDate,
                        getDestination: _getDestination(),
                        getQuantity: _getQuantity(),
                        setTrip: _setTrip,
                        setDepartureValue: _setDepartureValue,
                        setDestinationValue: _setDestinationValue,
                        setDepartureDate: _setDepartureDate,
                        bookTrip: _bookTrip)
                    : _BookRoundTripWidget(
                        key: UniqueKey(),
                        isOneWay: isOneWay,
                        departureValue: departureValue,
                        destinationValue: destinationValue,
                        departureDate: departureDate,
                        arrivalDate: arrivalDate,
                        getDestination: _getDestination(),
                        getQuantity: _getQuantity(),
                        setTrip: _setTrip,
                        setDepartureValue: _setDepartureValue,
                        setDestinationValue: _setDestinationValue,
                        setDepartureDate: _setDepartureDate,
                        setArrivalDate: _setArrivalDate,
                        bookTrip: _bookTrip),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BookTripOneTrip extends StatelessWidget {
  final bool isOneWay;
  final String departureValue;
  final String destinationValue;
  final DateTime departureDate;
  final List<String> getDestination;
  final List<String> getQuantity;
  final VoidCallback setTrip;
  final ValueChanged<String> setDepartureValue;
  final ValueChanged<String> setDestinationValue;
  final ValueChanged<DateTime> setDepartureDate;
  final VoidCallback bookTrip;

  const _BookTripOneTrip(
      {Key key,
      this.isOneWay,
      this.departureValue,
      this.destinationValue,
      this.departureDate,
      this.getDestination,
      this.getQuantity,
      this.setTrip,
      this.setDepartureValue,
      this.setDestinationValue,
      this.setDepartureDate,
      this.bookTrip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _BookTripActionChipTabWidget(
            toggleActionChip: setTrip,
            isToggled: isOneWay,
          ),
          _BookTripLocationWidget(
              key: UniqueKey(),
              title: 'Departure',
              value: departureValue,
              destinations: getDestination,
              onItemSelected: setDepartureValue),
          _BookTripLocationWidget(
              key: UniqueKey(),
              title: 'Destination',
              value: destinationValue,
              destinations: getDestination,
              onItemSelected: setDestinationValue),
          _BookTripCalenderWidget(
            key: UniqueKey(),
            title: "Departure Date",
            onDateChanged: setDepartureDate,
          ),
          _BookTripQuantityWidget(
            quantityList: getQuantity,
          ),
          _BookTripButtonWidget(
            onButtonClick: bookTrip,
          )
        ],
      ),
    );
  }
}

class _BookRoundTripWidget extends StatelessWidget {
  final bool isOneWay;
  final String departureValue;
  final String destinationValue;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final List<String> getDestination;
  final List<String> getQuantity;
  final VoidCallback setTrip;
  final ValueChanged<String> setDepartureValue;
  final ValueChanged<String> setDestinationValue;
  final ValueChanged<DateTime> setDepartureDate;
  final ValueChanged<DateTime> setArrivalDate;
  final VoidCallback bookTrip;

  const _BookRoundTripWidget({
    Key key,
    @required this.isOneWay,
    @required this.departureValue,
    @required this.destinationValue,
    @required this.departureDate,
    @required this.arrivalDate,
    @required this.getDestination,
    @required this.getQuantity,
    @required this.setTrip,
    @required this.setDepartureValue,
    @required this.setDestinationValue,
    @required this.setDepartureDate,
    @required this.setArrivalDate,
    @required this.bookTrip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _BookTripActionChipTabWidget(
            toggleActionChip: setTrip,
            isToggled: isOneWay,
          ),
          _BookTripLocationWidget(
              key: UniqueKey(),
              title: 'Departure',
              value: departureValue,
              destinations: getDestination,
              onItemSelected: setDepartureValue),
          _BookTripLocationWidget(
              key: UniqueKey(),
              title: 'Destination',
              value: destinationValue,
              destinations: getDestination,
              onItemSelected: setDestinationValue),
          _BookTripCalenderWidget(
            key: UniqueKey(),
            title: "Departure Date",
            onDateChanged: setDepartureDate,
          ),
          _BookTripCalenderWidget(
            key: UniqueKey(),
            title: "Arrival Date",
            onDateChanged: setArrivalDate,
          ),
          _BookTripQuantityWidget(
            quantityList: getQuantity,
          ),
          _BookTripButtonWidget(
            onButtonClick: bookTrip,
          )
        ],
      ),
    );
  }
}

class _BookTripButtonWidget extends StatelessWidget {
  final VoidCallback onButtonClick;

  _BookTripButtonWidget({@required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: double.infinity,
      child: RaisedButton(
          onPressed: onButtonClick,
          color: Colors.yellowAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_shopping_cart),
              SizedBox(
                width: 10,
              ),
              Text("Book Ticket")
            ],
          )),
    );
  }
}

class _BookTripQuantityWidget extends StatefulWidget {
  final List<String> quantityList;

  const _BookTripQuantityWidget({@required this.quantityList});

  @override
  State<StatefulWidget> createState() {
    return _BookTripQuantityWidgetState();
  }
}

class _BookTripQuantityWidgetState extends State<_BookTripQuantityWidget> {
  String quantity = "1";

  void _setQuantity(String value) {
    setState(() {
      quantity = value;
    });
  }

  List<DropdownMenuItem<String>> getMenuItems(List<String> items) {
    List<DropdownMenuItem<String>> result = items
        .map((String item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
        .toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Quantity"),
        SizedBox(
          width: 60,
          child: DropdownButton<String>(
            isExpanded: true,
            items: getMenuItems(widget.quantityList),
            onChanged: _setQuantity,
            value: quantity,
          ),
        )
      ],
    );
  }
}

class _BookTripCalenderWidget extends StatefulWidget {
  final String title;
  final ValueChanged<DateTime> onDateChanged;

  const _BookTripCalenderWidget(
      {Key key, @required this.title, @required this.onDateChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BookTripCalenderWidgetState();
  }
}

class _BookTripCalenderWidgetState extends State<_BookTripCalenderWidget> {
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
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: DateTime(2120));

    if (pickedDate != null) {
      _setSelectedDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ]);
  }
}

class _BookTripLocationWidget extends StatelessWidget {
  final String title;
  final String value;
  final List<String> destinations;
  final ValueChanged<String> onItemSelected;

  const _BookTripLocationWidget(
      {Key key,
      @required this.title,
      @required this.value,
      @required this.destinations,
      @required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        new _DestinationsDropdownMenu(
          destinations: destinations,
          value: value,
          onItemSelected: onItemSelected,
        )
      ],
    );
  }
}

class _DestinationsDropdownMenu extends StatelessWidget {
  final List<String> destinations;
  final String value;
  final ValueChanged<String> onItemSelected;
  _DestinationsDropdownMenu(
      {@required this.destinations,
      @required this.value,
      @required this.onItemSelected});

  List<DropdownMenuItem<String>> dropdownMenuItems(List<String> destinations) {
    List<DropdownMenuItem<String>> items =
        destinations.map((String destination) {
      return DropdownMenuItem<String>(
        value: destination,
        child: Text(destination),
      );
    }).toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      items: dropdownMenuItems(destinations),
      onChanged: onItemSelected,
      value: value,
    );
  }
}

class _BookTripActionChipTabWidget extends StatelessWidget {
  final VoidCallback toggleActionChip;
  final bool isToggled;
  _BookTripActionChipTabWidget(
      {@required this.toggleActionChip, @required this.isToggled});

  Widget getActionChip(String title, bool isToggled) {
    Widget toggledChip = ActionChip(
      label: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (!isToggled) {
          toggleActionChip();
        }
      },
      backgroundColor: Colors.green,
    );
    Widget unToggledChip = ActionChip(
        label: Text(title),
        onPressed: () {
          if (!isToggled) {
            toggleActionChip();
          }
        });

    return (isToggled) ? toggledChip : unToggledChip;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getActionChip('One Trip', isToggled),
        getActionChip('Round Trip', !isToggled),
      ],
    );
  }
}
