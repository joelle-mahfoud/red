import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/historyRewards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryRewardsGrid extends StatefulWidget {
  const HistoryRewardsGrid({Key key}) : super(key: key);

  @override
  _HistoryRewardsGridState createState() => _HistoryRewardsGridState();
}

class _HistoryRewardsGridState extends State<HistoryRewardsGrid> {
  int _rowperPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: KBackgroundColor,
        child: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData == null) {
              return Center(child: CircularProgressIndicator());
            } else if (projectSnap.hasData) {
              List<HistoryRewards> historyRewards = projectSnap.data;
              return PaginatedDataTable(
                header: const Text(
                  "History Rewards",
                  style: TextStyle(color: kPrimaryColor),
                ),
                rowsPerPage: _rowperPage,
                availableRowsPerPage: const [10, 15, 20],
                onRowsPerPageChanged: (int value) {
                  setState(() {
                    _rowperPage = value;
                  });
                },
                columns: kTableColumns,
                source: DessertDataSource(historyRewards),
              );
            }
            return Center();
          },
          future: futureHistoryRewards,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureHistoryRewards = fetchHistoryRewards();
  }

  Future<List<HistoryRewards>> futureHistoryRewards;
  Future<List<HistoryRewards>> fetchHistoryRewards() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        const_get_history_rewards +
        "?token=" +
        token +
        "&client_id=" +
        clientId.toString();
    print(url);
    dynamic responce =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print(" ${responce.body}");
    if (responce.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(responce.body);
      if (res['result'] == 1) {
        print(res);
        List<HistoryRewards> historyRewards = (res['data'] as List)
            .map((i) => HistoryRewards.fromJson(i))
            .toList();
        return historyRewards;
      } else {
        print(" ${res['message']}");
        return null;
      }
    }
    throw Exception('Failed to load');
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text('Date'),
  ),
  DataColumn(
    label: Text('Operation'),
  ),
  // DataColumn(
  //   label: Text('Reward Value'),
  //   numeric: true,
  // ),
  DataColumn(
    label: Text('Service/Offers'),
  ),
  DataColumn(
    label: Text('Start Date'),
    tooltip: 'Start Date',
    numeric: true,
  ),
  DataColumn(
    label: Text('End Date'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Total Price'),
    numeric: true,
  ),
];

////// Data source class for obtaining row data for PaginatedDataTable.
class DessertDataSource extends DataTableSource {
  final List<HistoryRewards> _desserts;
  DessertDataSource(this._desserts);
  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final HistoryRewards dessert = _desserts[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text(dessert.date_used)),
      DataCell(Text(
          (dessert.type == "0" ? "Redeem" : "Earn") + " €" + dessert.amount)),
      // DataCell(Text(dessert.amount,
      //     style: TextStyle(color: Colors.red, backgroundColor: Colors.yellow))),
      DataCell(Text(
        ((dessert.listingId == "") ? "Renew Package" : dessert.listingTitle),
        style: TextStyle(color: Colors.red),
      )),
      DataCell(Text(dessert.startDate)),
      DataCell(Text(dessert.endDate)),
      DataCell(Text(dessert.totalPrice == "" ? "" : dessert.totalPrice + " €")),
    ]);
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
