import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trial/bloc/weather_bloc.dart';

void main() {
  runApp(
    BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController cityNameController = TextEditingController();
    final _bloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 32, 47, 1),
        title: Text("Weather App"),
        actions: [
          InkWell(
              onTap: () {
                _bloc.add(ResetWeather());
                cityNameController.clear();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.refresh),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: cityNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Enter City Name", border: InputBorder.none),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(18, 32, 47, 0.8))),
                  onPressed: () {
                    _bloc.add(GetCityNameEvent(cityNameController.text));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    child: Text("Submit"),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                    margin: EdgeInsets.only(top: 100),
                    height: 300,
                    width: double.infinity,
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherInitial) {
                          return buildColumn(state, null);
                        } else if (state is WeatherLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is WeatherLoaded) {
                          return buildColumn(state, cityNameController.text);
                        }
                        return Center(
                          child: Text("No data found"),
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildColumn(WeatherState state, String city) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset(0, 0), blurRadius: 10, color: Colors.grey)
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            city == null
                ? Container()
                : Text("${city.toUpperCase()}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            buildRow("Temperature", state.temp.toString()),
            buildRow("Pressure", state.pressure.toString()),
            buildRow("Humidity", state.humidity.toString()),
            buildRow("Temperature Max", state.tempMax.toString()),
            buildRow("Temperature Min", state.tempMin.toString()),
          ],
        ),
      ),
    );
  }

  Row buildRow(String weatherHead, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          weatherHead,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
