import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageConverter extends StatefulWidget {
  const LanguageConverter({super.key});

  @override
  State<LanguageConverter> createState() => _LanguageConverterState();
}

class _LanguageConverterState extends State<LanguageConverter> {
  // creating varible for
  // first for our languages
  var languages = ['urdu', 'english', 'french'];
  // second for original(input) language
  var originLanguage = 'from';
  //third for distination language
  var distinationLanguage = 'to';
  // 4 for output
  var output = '';

  TextEditingController languageController = TextEditingController();

  void convert(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var convertion = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = convertion.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Failed to convert';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'english') {
      return 'en';
    } else if (language == 'urdu') {
      return 'ur';
    } else if (language == 'french') {
      return 'fr';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // making appbar
      backgroundColor: Color(0xff10223d),

      appBar: AppBar(
        title: Text("Language converter"),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      // now body
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      distinationLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        distinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter you text',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a text to convert it';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2b3c5a)),
                    onPressed: () {
                      convert(
                          getLanguageCode(originLanguage),
                          getLanguageCode(distinationLanguage),
                          languageController.text.toString());
                    },
                    child: Text('Convert')),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '\n$output',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
