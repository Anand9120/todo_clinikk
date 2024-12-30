import 'package:flutter/material.dart';
import 'package:todo_clinikk/models/post_model.dart';
import 'package:todo_clinikk/services/api_services.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Post>? posts;
  bool isLoading = false;
  String errorMessage = '';
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchPostsByUserId(String? userId) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final data = userId != null && userId.isNotEmpty
          ? await ApiService.fetchPostsByUserId(userId)
          : await ApiService.fetchPosts();
      setState(() {
        posts = data;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPostsByUserId(null); // Fetch all posts initially.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Search by User ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                fetchPostsByUserId(value.isEmpty ? null : value);
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text('Error: $errorMessage'))
                : posts == null || posts!.isEmpty
                ? const Center(child: Text('No posts found.'))
                : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                final post = posts![index];
                return ListTile(
                  title: Text(post.title,style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  subtitle: Text(post.body),
                  style: ListTileStyle.list,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
