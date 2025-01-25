// ...existing code...
import 'package:provider/provider.dart';
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
// ...existing code...

  Widget build(BuildContext context) {
            title: Text(post.content),
            subtitle: Text('Scheduled for: ${post.scheduledTime}'),
            trailing: CustomButton(
              label: 'Schedule',
              onPressed: () {
                // Trigger scheduling functionality
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

    final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Social Media Manager')),
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];
          return ListTile(
      body: ListView.builder(
        itemCount: postProvider.posts.length,
import '../providers/post_provider.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  @override