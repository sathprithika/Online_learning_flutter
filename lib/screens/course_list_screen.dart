import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Learning - Data'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6FB7AE), Color(0xFFFFC288)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('username') // Order by username
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No data found.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ); // Show message when no data is available
          }

          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var user = data[index];
              return AnimatedOpacity(
                duration: Duration(seconds: 1), // Fade-in animation
                opacity: 1.0,
                child: Card( // Wrap each item in a Card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  elevation: 10, // Increased elevation for deeper shadow
                  shadowColor: Colors.black.withOpacity(0.2), // Deeper shadow
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Padding inside ListTile
                    tileColor: Colors.white, // White background for each card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded card corners
                    ),
                    title: Text(
                      'Username: ${user['username']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal[700], // Teal color for title
                        fontFamily: 'Roboto', // Custom font
                      ),
                    ),
                    subtitle: Text(
                      'Course: ${user['course']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600], // Grey color for subtitle
                        fontFamily: 'Roboto', // Custom font
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[600]),
                    onTap: () {
                      // Handle onTap (could navigate to a new screen)
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action when the button is pressed
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[600],
      ),
    );
  }
}
