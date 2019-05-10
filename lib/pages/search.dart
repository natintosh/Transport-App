import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _SearchContent()),
    );
  }
}

class _SearchContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchContentState();
  }
}

class _SearchContentState extends State<_SearchContent> {
  TextEditingController _searchTextController = TextEditingController();

  void _onClearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CloseButton(),
            Expanded(
              child: Hero(
                tag: 'searchCardHero',
                child: Material(
                  child: Card(
                      shape: StadiumBorder(),
                      elevation: 8,
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        customBorder: StadiumBorder(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                          child: TextFormField(
                            controller: _searchTextController,
                            style: TextStyle(fontSize: 20.0),
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: _onClearSearch)),
                          ),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: buildSearchResultList(),
        )
      ],
    );
  }

  Widget buildSearchResultList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Placeholder(
              fallbackHeight: 20,
            ),
            subtitle: Placeholder(
              fallbackHeight: 20,
            ),
            trailing: Icon(Icons.chevron_right),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 10);
  }
}
