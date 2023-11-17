import 'package:flutter/material.dart';

import 'package:nfc_manager/nfc_manager.dart';

class ReadNfc extends StatefulWidget {
  const ReadNfc({super.key});

  @override
  State<ReadNfc> createState() => _ReadNfcState();
}

class _ReadNfcState extends State<ReadNfc> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  //
  //
  //read NFC tag
  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(color: Colors.cyanAccent),
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
                    " READ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46),
                  ),
                ],
              ),
              Image.asset(
                "assets/phone.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: _tagRead,
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
                                                    style: TextStyle(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
