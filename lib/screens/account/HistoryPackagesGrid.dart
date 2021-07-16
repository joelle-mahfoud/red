import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcircleflutter/apis/api.dart';
import 'package:redcircleflutter/constants.dart';
import 'package:redcircleflutter/models/userPlans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPackagesGrid extends StatefulWidget {
  const HistoryPackagesGrid({Key key}) : super(key: key);

  @override
  _HistoryPackagesGrid createState() => _HistoryPackagesGrid();
}

class _HistoryPackagesGrid extends State<HistoryPackagesGrid> {
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
              List<UserPlans> history = projectSnap.data;
              return PaginatedDataTable(
                header: const Text(
                  "History Packages",
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
                source: DessertDataSource(history),
              );
            }
            return Center();
          },
          future: futureUserPlan,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureUserPlan = fetchUserPlan();
  }

  Future<List<UserPlans>> futureUserPlan;
  Future<List<UserPlans>> fetchUserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String clientId = _pref.getString(kclientIdPrefKey);
    String url = root +
        "/" +
        const_get_user_plans +
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
        List<UserPlans> userPlans =
            (res['data'] as List).map((i) => UserPlans.fromJson(i)).toList();

        return userPlans;
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
    label: Text('Package Name'),
  ),
  DataColumn(
    label: Text('Start Date'),
  ),
  DataColumn(
    label: Text('Price'),
    numeric: true,
  ),
  DataColumn(
    label: Text('End Date'),
  ),
  DataColumn(
    label: Text('Trial/Months'),
    numeric: true,
  ),
  DataColumn(
    label: Text('expiryDate'),
  ),
];

////// Data source class for obtaining row data for PaginatedDataTable.
class DessertDataSource extends DataTableSource {
  final List<UserPlans> userPlans;
  DessertDataSource(this.userPlans);
  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= userPlans.length) return null;
    final UserPlans up = userPlans[index];
    final DateFormat formatter = DateFormat('yyyy-MM-dd KK:mm');
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text(up.titleEn)),
      DataCell(Text(formatter.format(up.purchacedDate))),
      DataCell(Text("€ " + up.price)),
      DataCell(Text(formatter.format(up.purchacedDate))),
      DataCell(Text(up.trial)),
      DataCell(Text(formatter.format(up.expiryDate)))
    ]);
  }

  @override
  int get rowCount => userPlans.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
