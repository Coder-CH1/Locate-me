import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width/0.2,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Search places',
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.blueAccent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
