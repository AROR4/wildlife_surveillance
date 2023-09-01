import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(photos: photos, deleteAllPhotos: deleteAllPhotos),
      body: Center(
        child: photos.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 25.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      _showDeleteConfirmationDialog(index);
                    },
                    child: Image.file(File(photos[index])),
                    //child: Image.network(photos[index]),
                  );
                },
              ).px12()
            : "Gallery is empty".text.size(25).make(),
      ).py64(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await captureAndSaveImage();
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

Future<void> savePhotoLocally(String fileName, List<int> imageBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(imageBytes);
      setState(() {
        photos.add(file.path);
      });
      print('Photo saved locally: ${file.path}');
    } catch (e) {
      print('Error saving photo: $e');
    }
  }

  Future<void> captureAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageBytes = File(pickedFile.path).readAsBytesSync();
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await savePhotoLocally(fileName, imageBytes);
    }
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Photo'),
          content: Text('Are you sure you want to delete this photo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deletePhoto(index); // Delete the photo
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void deletePhoto(int index) {
    setState(() {
      File photoFile = File(photos[index]);
      if (photoFile.existsSync()) {
        photoFile.deleteSync();
      }
      photos.removeAt(index);
    });
  }

  void deleteAllPhotos() {
    _showDeleteAllConfirmationDialog();
  }

  void _showDeleteAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete All Photos'),
          content: Text('Are you sure you want to delete all photos?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllPhotos(); // Delete all photos
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete All'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllPhotos() {
    setState(() {
      for (String filePath in photos) {
        File photoFile = File(filePath);
        if (photoFile.existsSync()) {
          photoFile.deleteSync();
        }
      }
      photos.clear();
    });
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> photos;
  final Function() deleteAllPhotos;

  CustomAppBar({
    required this.photos,
    required this.deleteAllPhotos,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: "Gallery".text.color(Colors.black).size(24).make(),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'deleteAll') {
              deleteAllPhotos(); // Call the deleteAllPhotos function
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'deleteAll', // Use a unique value
                child: Text('Delete All Photos'),
              ),
            ];
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ],
      flexibleSpace: Container(
        height: 144,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 136, 0),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.0))),
      ),
    );
  }
}