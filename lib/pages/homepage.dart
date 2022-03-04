import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  var f = DateFormat("dd/MM/yyyy EEEE");

  var modVal = 0;
  var housename = "";

  String _houseResult(year, day) {
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mahabote"),
      ),
      body: _homeDesign(),
    );
  }

  TextStyle selectedColor(val) => TextStyle(
      color: housename == val ? Theme.of(context).primaryColor : Colors.black);

  Text _label_text(val) => Text(val, style: (selectedColor(val)));

  Widget _mahabote_layout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(" "),
                _label_text("အဓိပတိ"),
                const Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _label_text("အထွန်း"),
                _label_text("သိုက်"),
                _label_text("ရာဇ"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _label_text("မရဏ"),
                _label_text("ဘင်္ဂ"),
                _label_text("ပုတိ"),
              ],
            ),
          ],
        ),
      );

  Widget _homeDesign() => ListView(
        children: [
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2050),
                      helpText: "Select your birthday",
                      cancelText: "Not Now",
                    );
                    if (picked != null) {
                      int myanmarYear;

                      if (picked.month < 4) {
                        myanmarYear = picked.year - 637;
                      } else {
                        myanmarYear = picked.year - 638;
                      }

                      setState(() {
                        selectedDate = picked;
                        modVal = myanmarYear % 7;
                        housename = _houseResult(myanmarYear, picked.weekday);
                        selected = true;
                      });
                    }
                  },
                  child: selected
                      ? Text(f.format(selectedDate))
                      : const Text("Select your birthday")),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(12),
              height: 175,
              child: Card(
                child: Center(
                  child: _mahabote_layout(),
                ),
              )),
          Container(
            margin: const EdgeInsets.all(12),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [Text("အကြွင်း $modVal"), Text("$housename")],
              ),
            )),
          )
        ],
      );
}
