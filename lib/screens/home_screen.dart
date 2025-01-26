import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/stats_card.dart';
import '../widgets/new_post_dialog.dart';
import '../widgets/analytics_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: CustomNavigationDrawer(),
      body: RefreshIndicator(
        onRefresh: () => postProvider.fetchPosts(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchAndFilter(),
                SizedBox(height: 24),
                _buildStatsGrid(screenSize, postProvider),
                SizedBox(height: 24),
                AnalyticsChart(),
                SizedBox(height: 24),
                _buildRecentPosts(postProvider),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewPostDialog(context),
        label: Text('New Post'),
        icon: Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Shit Poster Agent'),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    selected: _filter == 'all',
                    onSelected: (selected) => setState(() => _filter = 'all'),
                  ),
                  SizedBox(width: 8),
                  _FilterChip(
                    label: 'Scheduled',
                    selected: _filter == 'scheduled',
                    onSelected: (selected) =>
                        setState(() => _filter = 'scheduled'),
                  ),
                  SizedBox(width: 8),
                  _FilterChip(
                    label: 'Published',
                    selected: _filter == 'published',
                    onSelected: (selected) =>
                        setState(() => _filter = 'published'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(Size screenSize, PostProvider postProvider) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: screenSize.width > 1200 ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        StatsCard(
          title: 'Scheduled Posts',
          value: '${postProvider.posts.length}',
          icon: Icons.schedule,
          color: Colors.blue,
        ),
        StatsCard(
          title: 'Active Platforms',
          value: '4',
          icon: Icons.share,
          color: Colors.green,
        ),
        // Add more stats cards
      ],
    );
  }

  Widget _buildRecentPosts(PostProvider postProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Posts',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 1200
                    ? 3
                    : constraints.maxWidth > 800
                        ? 2
                        : 1,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) {
                final post = postProvider.posts[index];
                return PostCard(post: post);
              },
            );
          },
        ),
      ],
    );
  }

  void _showNewPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NewPostDialog(),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.blue.withOpacity(0.2),
    );
  }
}
