import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ZipMaker extends StatefulWidget {
  @override
  _ZipMakerState createState() => _ZipMakerState();
}

class _ZipMakerState extends State<ZipMaker> {
  writeFile(String text) async {
    Directory? directory = await getExternalStorageDirectory();
    print(directory!.path);
    String dirPath = directory.path;
    final File createFile = File('$dirPath/demoTextFile.txt');
    String filePath = '$dirPath/demoTextFile.txt';
    await createFile.writeAsString(text);
  }

  readFile() async {
    Directory? directory = await getExternalStorageDirectory();
    String dirpath = directory!.path;
    File file = File('$dirpath/demoTextFile.txt');
    String fileContent = await file.readAsString();
    print('File Content: $fileContent');
  }

  zipMaker() async {
    Directory? directory = await getExternalStorageDirectory();
    String dirPath = directory!.path;
    print(directory.path);
    var zipEncoder = ZipFileEncoder();
    zipEncoder.create(directory.path + "/" + 'demoJPGFile.zip');
    zipEncoder.addFile(File('$dirPath/demoTextFile.txt'));
    zipEncoder.close();
  }

  zipExtractor() async {
    Directory? directory = await getExternalStorageDirectory();
    String dirPath = directory!.path;
    print(directory.path);
    List<int> bytes;
    bytes = File('$dirPath/demoJPGFile.zip').readAsBytesSync();

    final archive = ZipDecoder().decodeBytes(bytes);

    // bytes,
    // verify: true,
    // password: "rahad",

    for (ArchiveFile file in archive) {
      String filename = file.name;
      String decodePath = (dirPath + filename);
      if (file.isFile) {
        List<int> data = file.content;
        File(decodePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory(decodePath).create(recursive: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String text;
    return Scaffold(
      appBar: AppBar(
        title: Text("Zip Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              width: 250.0,
              child: FlatButton(
                onPressed: () {
                  writeFile(text = 'Spectrum Engineering Consortium Ltd');
                },
                child: const Text("Write"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 250.0,
              child: FlatButton(
                onPressed: () {
                  readFile();
                },
                child: const Text("Read"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 250.0,
              child: FlatButton(
                onPressed: () {
                  zipMaker();
                },
                child: const Text("Make Zip"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 250.0,
              child: FlatButton(
                onPressed: () {
                  zipExtractor();
                },
                child: const Text("Extract Zip"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
