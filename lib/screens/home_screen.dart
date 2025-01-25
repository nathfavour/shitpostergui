import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Social Media Manager')),
      body: ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];
          return ListTile(
            title: Text(post.content),
            subtitle: Text('Scheduled for: ${post.scheduledTime}'),
            trailing: CustomButton(
              label: 'Schedule',
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    postProvider.schedulePost(post.id, selectedDate);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new post functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
