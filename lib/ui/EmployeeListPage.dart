import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vizmotest/blocs/employee/employee_bloc.dart';
import 'package:vizmotest/repository/models/employeeModel.dart';
import 'package:vizmotest/ui/EmployeeDetailsPage.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  //variable for pagination
  int currentPage= 1;

  @override
  void initState() {
loadPage(currentPage, 10);
    // TODO: implement initState
    super.initState();
  }

  // variables for search implementation
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Employees');

// list of employees
  late List<EmployeeModel> _employeeList;

  // pagination loadpageFunction
  void loadPage(int pageNum, int limit) {
    BlocProvider.of<EmployeeBloc>(context)
        .add(GetEmployeesByPage(currentPage, limit));
    setState(() {});
  }

  //checking weather any sorting has bee done to hide paginator
  bool isSorted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar =  ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          onChanged: (value){
                            if(value.isNotEmpty){
                              BlocProvider.of<EmployeeBloc>(context).add(SearchEmployeesByName(value));   //searching employees by name
                            } else {
                              loadPage(currentPage, 10);
                            }

                          },
                          autofocus: true,

                          decoration: InputDecoration(
                          focusColor: Colors.white,

                            hintText: 'Search Employee...',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),

                        ),
                      );
                    }
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Employees');
                    loadPage(currentPage, 10);   //refreshing page if search is cancelled
                  }
                });
              },
              icon: customIcon,
            )
          ],
        ),
        floatingActionButton:!isSorted ? currentPage != 1
            ? Container(
                width: MediaQuery.of(context).size.width * .90,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: () => {
                        if (currentPage > 1) {loadPage(currentPage--, 10)}
                      },
                      child: Icon(Icons.navigate_before_rounded),
                      heroTag: "fab1",
                    ),
                    FloatingActionButton(
                      onPressed: () => {loadPage(currentPage++, 10)},
                      child: Icon(Icons.navigate_next_rounded),
                      heroTag: "fab2",
                    ),
                  ],
                ))
            : FloatingActionButton(
                onPressed: () => {loadPage(currentPage++, 10)},
                child: Icon(Icons.navigate_next_rounded),
                heroTag: "fab2",
              ):null,
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoaded) {
              _employeeList = BlocProvider.of<EmployeeBloc>(context)
                  .employeeModel; // employee list
              if(_employeeList.isEmpty){
                return Container(
                  child: Center(
                  child: Text('Sorry No Employees Found',style: TextStyle(fontSize: 18),),
                  ),
                );
              }
              return Column(
                children: [
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         !isSorted? TextButton.icon(
                            label: Text('Sort'),
                            icon: Icon(Icons.sort),
                            onPressed: () {
                             showSortDialog();
                            },
                          ):TextButton.icon(
                           label: Text('Change Sort'),
                           icon: Icon(Icons.sort_by_alpha),
                           onPressed: () {
                             showSortDialog();
                           },
                         ),
                          TextButton.icon(
                            label: Text('Filter'),
                            icon: Icon(Icons.filter_alt_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: _employeeList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: GestureDetector(
                                onTap: (){

                                  Navigator.push(context,MaterialPageRoute(builder: (context) => EmployeeDetailsPage(employeeModel: _employeeList[index])));
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    _employeeList[index]
                                                        .avatar
                                                        .toString()),
                                              )),
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  .20,
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  .20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _employeeList[index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                'Employee Id : ' +
                                                    _employeeList[index]
                                                        .id
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              );

            }
            if (state is EmployeeLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          },
        ));
  }


  void showSortDialog( ){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Sort By'),
              content: Container(
                width: MediaQuery.of(context).size.width *.80,
                height: isSorted? MediaQuery.of(context).size.height * .35 : MediaQuery.of(context).size.height * .30,
                child: ListView(
                 physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text('By ID Ascending'),
                      leading: Icon(Icons.arrow_upward),
                      onTap: (){
                        BlocProvider.of<EmployeeBloc>(context).add(SortEmployees('id', 'asc'));
                        setState(() {
                          isSorted = true;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      onTap: (){
                        BlocProvider.of<EmployeeBloc>(context).add(SortEmployees('id', 'desc'));
                        setState(() {
                          isSorted = true;
                        });
                        Navigator.pop(context);
                      },
                      title: Text(' By ID Descending '),
                      leading:
                      Icon(Icons.arrow_downward),
                    ),
                    ListTile(
                      onTap: (){
                        BlocProvider.of<EmployeeBloc>(context).add(SortEmployees('name', 'asc'));
                        setState(() {
                          isSorted = true;
                        });
                        Navigator.pop(context);
                      },
                      title: Text('By Name Ascending'),
                      leading: Icon(Icons.sort_by_alpha),
                    ),
                    ListTile(
                      onTap: (){
                        BlocProvider.of<EmployeeBloc>(context).add(SortEmployees('name', 'desc'));
                        setState(() {
                          isSorted = true;
                        });
                        Navigator.pop(context);
                      },
                      title: Text('By Name Descending '),
                      leading:
                      Icon(Icons.sort_by_alpha),
                    ),
                    isSorted ? ListTile(
                      onTap: (){
                        loadPage(1, 10);
                        setState(() {
                          isSorted = false;
                        });
                        Navigator.pop(context);
                      },
                      title: Text('Remove all Sort '),
                      leading:
                      Icon(Icons.cancel_outlined),
                    ): Container()
                  ],
                ),
              ));
        });
  }
}
