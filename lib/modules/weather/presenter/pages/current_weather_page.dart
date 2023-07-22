import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/widgets/app_botton.dart';

class CurrentWeatPage extends StatefulWidget {
  const CurrentWeatPage({super.key});

  @override
  State<CurrentWeatPage> createState() => _CurrentWeatPageState();
}

class _CurrentWeatPageState extends State<CurrentWeatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBotton(cont: context, selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  height: 170,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 20.0),
                            child: Text(
                              'Cidade',
                              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Image.network('http://openweathermap.org/img/wn/10d@2x.png'),
                              SizedBox(width: 5),
                              Text(
                                '60°',
                                style: const TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text('Chuva'),
                                  Text('min: 14°'),
                                  Text('max: 20°'),
                                ],
                              ),
                              SizedBox(width: 20,)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}