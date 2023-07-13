import 'dart:io';
import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget{
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen>{
  File? _selectedImage;
  PlaceLocation _selectedLocation = const PlaceLocation(
      address: '', 
      latitude: 37.422, 
      longitude: -122.084);
  final _titleController = TextEditingController();

  void _savePlace(){
    final enteredTitle = _titleController.text;

    //when map api is working we use this condition
    // if(enteredTitle.isEmpty || _selectedImage==null || _selectedLocation==null){
    //   return;
    // } 

    if(enteredTitle.isEmpty || _selectedImage==null){
      return;
    }

    ref
      .read(userPlacesProvider.notifier)
      .addPlace(enteredTitle, _selectedImage!,_selectedLocation);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 12,),
            //Image input
            ImageInput(onPickedImage: (image){
              _selectedImage=image;
            },),
            const SizedBox(height: 12,),
            LocationInput(onSelectLocation: (location){
              _selectedLocation = location;
            },),
            const SizedBox(height: 12,),
            ElevatedButton.icon(
              onPressed: _savePlace, 
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}