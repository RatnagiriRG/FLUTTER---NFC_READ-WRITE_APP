import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class WriteNfc extends StatefulWidget {
  const WriteNfc({super.key});

  @override
  State<WriteNfc> createState() => _WriteNfcState();
}

class _WriteNfcState extends State<WriteNfc> {
  final TextEditingController _textEditingController = TextEditingController();
  ValueNotifier<dynamic> result = ValueNotifier(null);

  void _writeNFC(String data) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'NFC not writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText(data),
        NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        NdefRecord.createMime('text/plain', Uint8List.fromList(data.codeUnits)),
        NdefRecord.createExternal(
            'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success Write The NFC';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
  //
  //
  //lock nfc
  //
  //
  
  void _WriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'NFC not Set';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Successfully Locked NFC Data ';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
  //

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.cyanAccent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/nfc.png",
                    width: 45,
                  ),
                  Text(
                    " WRITE",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/phone.png",
                width: 150,
                height: 150,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      foregroundColor: Colors.cyanAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  icon: Icon(Icons.refresh_outlined),
                  label: Text("Refresh")),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: TextField(cursorColor: Colors.white,
                
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: "Write to NFC...!",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        String data = _textEditingController.text;
                        if (data.isNotEmpty) {
                          _writeNFC(data);
                        } else {}
                      },
                      child: Text("Save "),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          foregroundColor: Colors.cyanAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 139, 166),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/phone.png",
                        width: 50,
                      ),
                      Expanded(
                          child: FutureBuilder<bool>(
                              future: NfcManager.instance.isAvailable(),
                              builder: (context, snapshot) => snapshot.data !=
                                      true
                                  ? Center(
                                      child: Text(
                                      "NFC Available : ${snapshot.data}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyanAccent),
                                    ))
                                  : Flex(
                                      direction: Axis.vertical,
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            child: Container(
                                              constraints:
                                                  BoxConstraints.expand(),
                                              child: SingleChildScrollView(
                                                child: ValueListenableBuilder(
                                                  valueListenable: result,
                                                  builder:
                                                      (context, value, child) =>
                                                          Text(
                                                    "${value ?? " "}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.cyanAccent),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _WriteLock,
                      child: Text(" SET THE NFC DATA"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          foregroundColor: Colors.cyanAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
