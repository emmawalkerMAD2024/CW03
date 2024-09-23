import 'dart:async'; 
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
  Color petColor = Colors.yellow; 
  TextEditingController nameController = TextEditingController();
  bool nameConfirmed = false;
  Timer? hungerTimer; 

  @override
  void initState() {
    super.initState();
    _startHungerTimer(); 
  }

  @override
  void dispose() {
    hungerTimer?.cancel(); 
    super.dispose();
  }

 
  void _startHungerTimer() {
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel - 5).clamp(0, 100); 
        _updateHappiness(); 
        _updatePetColor(); 
      });
    });
  }


  void _updatePetColor() {
    if (happinessLevel > 70) {
      petColor = Colors.green; 
    } else if (happinessLevel >= 30) {
      petColor = Colors.yellow; 
    } else {
      petColor = Colors.red;
    }
  }

  String _getPetMood() {
    if (happinessLevel > 70) {
      return 'Happy 😊';
    } else if (happinessLevel >= 30) {
      return 'Neutral 😐';
    } else {
      return 'Unhappy 😢';
    }
  }

  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updatePetColor(); 
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _updatePetColor(); 
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel + 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _updatePetColor(); 
  }


  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
    _updatePetColor(); 
  }

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
                      color: petColor, 
                    ),
                    child: Center(
                      child: Text(
                        'Pet',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  
                  Image.asset(
                    'C:/Users/emmaw/Downloads/CATWHITE.png', 
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
                  
                  SizedBox(height: 16.0),
                  Text(
                    'Mood: ${_getPetMood()}',
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
