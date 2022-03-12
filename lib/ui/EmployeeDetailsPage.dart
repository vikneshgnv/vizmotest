import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vizmotest/blocs/checkin/check_in_bloc.dart';
import 'package:vizmotest/repository/models/checkInModel.dart';
import 'package:vizmotest/repository/models/employeeModel.dart';

class EmployeeDetailsPage extends StatefulWidget {
  EmployeeDetailsPage({Key? key, required this.employeeModel})
      : super(key: key);
  EmployeeModel employeeModel;
  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<CheckInBloc>(context)
        .add(GetAllCheckIns(int.parse(widget.employeeModel.id.toString())));  // api call to get all checkin data
    // TODO: implement initState
    super.initState();
  }

  List<CheckInModel>? checkInModelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Employee Detail card
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .15,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(widget
                                              .employeeModel.avatar
                                              .toString()),
                                        )),
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    height:
                                        MediaQuery.of(context).size.width * .25,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.employeeModel.name.toString(),
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        "Employee Id : " +
                                            widget.employeeModel.id.toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Email  : '),
                                  Text(widget.employeeModel.email.toString(),
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Phone  : ',
                                      style: TextStyle(fontSize: 14)),
                                  Text(widget.employeeModel.phone.toString(),
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Country  : ',
                                      style: TextStyle(fontSize: 14)),
                                  Text(widget.employeeModel.country.toString(),
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Birthday  : ',
                                      style: TextStyle(fontSize: 16)),
                                  Text(
                                    DateFormat.yMMMd().format(DateTime.parse(
                                        widget.employeeModel.birthday
                                            .toString())),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Checkin search by Id TextField
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            BlocProvider.of<CheckInBloc>(context).add(
                                GetCheckInwithCheckInID(
                                    int.parse(
                                        widget.employeeModel.id.toString()),
                                    int.parse(value)));// api call to get all checkin data
                          } else{
                            BlocProvider.of<CheckInBloc>(context)
                                .add(GetAllCheckIns(int.parse(widget.employeeModel.id.toString())));
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: 'Search CheckIn By ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),


                  //ListView to show checkin data
                  BlocBuilder<CheckInBloc, CheckInState>(
                    builder: (context, state) {
                      if (state is CheckInLoaded) {
                        checkInModelList = BlocProvider.of<CheckInBloc>(context).checkInList;
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: checkInModelList!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Check In  : ',
                                                style:
                                                    TextStyle(fontSize: 16)),
                                            Text(
                                                DateFormat.yMMMd().format(
                                                    DateTime.parse(
                                                        checkInModelList![
                                                                index]
                                                            .checkin
                                                            .toString())),
                                                style:
                                                    TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Location  : ',
                                                style:
                                                    TextStyle(fontSize: 16)),
                                            Text(
                                                checkInModelList![index]
                                                    .location
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('purpose  : ',
                                                style:
                                                    TextStyle(fontSize: 16)),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .40,
                                              child: Text(
                                                checkInModelList![index]
                                                    .purpose
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 16),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            });
                      }else if(state is CheckInError){
                        return Container(
                          height: MediaQuery.of(context).size.height * .40,
                          child: Center(
                            child: Text('Sorry , Something went Wrong'),
                          ),
                        );
                      }
                      return Container(
                        height: MediaQuery.of(context).size.height * .40,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
