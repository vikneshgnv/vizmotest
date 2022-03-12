import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizmotest/blocs/employee/employee_bloc.dart';
import 'package:vizmotest/ui/EmployeeListPage.dart';
import 'package:vizmotest/ui/ProfilePage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //currentpage
  int currentPageIndex = 0;

  //page controller
  PageController _pageController = PageController();

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: PageView(
        controller: _pageController,
        onPageChanged: (value){
          setState(() {
            currentPageIndex=value;
          });
        },
        children: [
          EmployeeListPage(),
          ProfilePage()
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (value){
          setState(() {
            currentPageIndex = value;
            _pageController.animateToPage(currentPageIndex, duration:Duration(milliseconds: 500), curve: Curves.easeIn);
          });
        },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.wc),
                label: 'Employees'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: 'Profile'),

          ]),
    );
  }
}
