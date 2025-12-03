import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../../models/portfolio_item.dart';
import '../../providers/portfolio_provider.dart';
import '../../providers/auth_provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPortfolio();
  }

  Future<void> _loadPortfolio() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final portfolioProvider = Provider.of<PortfolioProvider>(context, listen: false);
    
    if (authProvider.currentUser != null) {
      await portfolioProvider.loadPortfolio(authProvider.currentUser!.id);
    }
  }

  Future<void> _addImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null && mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final portfolioProvider = Provider.of<PortfolioProvider>(context, listen: false);

      final item = PortfolioItem(
        id: const Uuid().v4(),
        userId: authProvider.currentUser!.id,
        type: MediaType.image,
        url: image.path,
        uploadedAt: DateTime.now(),
      );

      await portfolioProvider.addItem(item);
    }
  }

  Future<void> _addVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null && mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final portfolioProvider = Provider.of<PortfolioProvider>(context, listen: false);

      final item = PortfolioItem(
        id: const Uuid().v4(),
        userId: authProvider.currentUser!.id,
        type: MediaType.video,
        url: video.path,
        uploadedAt: DateTime.now(),
      );

      await portfolioProvider.addItem(item);
    }
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Add Image'),
              onTap: () {
                Navigator.pop(context);
                _addImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Add Video'),
              onTap: () {
                Navigator.pop(context);
                _addVideo();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddOptions,
          ),
        ],
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, portfolioProvider, child) {
          if (portfolioProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (portfolioProvider.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Portfolio Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start building your portfolio',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _showAddOptions,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Item'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: portfolioProvider.items.length,
            itemBuilder: (context, index) {
              final item = portfolioProvider.items[index];
              return _buildPortfolioCard(item, portfolioProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildPortfolioCard(PortfolioItem item, PortfolioProvider provider) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (item.type == MediaType.image)
            Image.file(
              File(item.url),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          else
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 60,
                ),
              ),
            ),
          
          // Delete button
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Item'),
                      content: const Text('Are you sure you want to delete this item?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('DELETE'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await provider.removeItem(item.id);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
