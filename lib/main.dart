import 'dart:async'; // Importing Timer

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Jared II";
  int happinessLevel = 50;
  int hungerLevel = 50;
  Color petColor = Colors.yellow; // Default color for neutral state
  TextEditingController nameController = TextEditingController();
  bool nameConfirmed = false;
  Timer? hungerTimer; // Timer for decreasing hunger automatically

  @override
  void initState() {
    super.initState();
    _startHungerTimer(); // Start the hunger timer when the app starts
  }

  @override
  void dispose() {
    hungerTimer?.cancel(); // Cancel the timer when the app is disposed
    super.dispose();
  }

  // Function to start the hunger timer
  void _startHungerTimer() {
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel - 5).clamp(0, 100); // Decrease hunger level by 5 every 30 seconds
        _updateHappiness(); // Update happiness based on hunger
        _updatePetColor(); // Update color based on happiness
      });
    });
  }

  // Function to update pet color based on happiness level
  void _updatePetColor() {
    if (happinessLevel > 70) {
      petColor = Colors.green; // Happy
    } else if (happinessLevel >= 30) {
      petColor = Colors.yellow; // Neutral
    } else {
      petColor = Colors.red; // Unhappy
    }
  }

  // Function to get the pet's mood text and emoji
  String _getPetMood() {
    if (happinessLevel > 70) {
      return 'Happy 😊';
    } else if (happinessLevel >= 30) {
      return 'Neutral 😐';
    } else {
      return 'Unhappy 😢';
    }
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updatePetColor(); // Update color based on happiness
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _updatePetColor(); // Update color based on happiness
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel + 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _updatePetColor(); // Update color based on happiness
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
    _updatePetColor(); // Update color based on happiness
  }

  // Function to confirm the pet's name
  void _confirmName() {
    setState(() {
      petName = nameController.text;
      nameConfirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: nameConfirmed
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: petColor, // Dynamic color based on happiness
                    ),
                    child: Center(
                      child: Text(
                        'Pet',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  
                  // Adding the image of the pet
                  Image.asset(
                    'C:/Users/emmaw/Downloads/CATWHITE.png', // Replace with the path of your image asset
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  
                  SizedBox(height: 16.0),
                  Text(
                    'Name: $petName',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Happiness Level: $happinessLevel',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  
                  // Display mood indicator
                  SizedBox(height: 16.0),
                  Text(
                    'Mood: ${_getPetMood()}', // Show mood and emoji
                    style: TextStyle(fontSize: 24.0),
                  ),
                  
                  SizedBox(height: 16.0),
                  Text(
                    'Hunger Level: $hungerLevel',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _playWithPet,
                    child: Text('Play with Your Pet'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _feedPet,
                    child: Text('Feed Your Pet'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter a name for your pet:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pet Name',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _confirmName,
                    child: Text('Confirm Name'),
                  ),
                ],
              ),
      ),
    );
  }
}
