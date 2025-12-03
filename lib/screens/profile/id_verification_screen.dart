import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'dart:io';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _idFrontImage;
  XFile? _idBackImage;
  XFile? _selfieImage;
  bool _isSubmitting = false;

  Future<void> _pickImage(ImageType type) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        switch (type) {
          case ImageType.idFront:
            _idFrontImage = image;
            break;
          case ImageType.idBack:
            _idBackImage = image;
            break;
          case ImageType.selfie:
            _selfieImage = image;
            break;
        }
      });
    }
  }

  Future<void> _submitVerification() async {
    if (_idFrontImage == null || _idBackImage == null || _selfieImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required images')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.updateUserVerification(true);

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification submitted successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              size: 80,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Verify Your Identity',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            Text(
              'Please provide the following documents to verify your identity',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // ID Front
            _buildImageUploadCard(
              title: 'ID Front',
              description: 'Upload the front of your ID',
              image: _idFrontImage,
              onTap: () => _pickImage(ImageType.idFront),
            ),
            
            const SizedBox(height: 16),
            
            // ID Back
            _buildImageUploadCard(
              title: 'ID Back',
              description: 'Upload the back of your ID',
              image: _idBackImage,
              onTap: () => _pickImage(ImageType.idBack),
            ),
            
            const SizedBox(height: 16),
            
            // Selfie
            _buildImageUploadCard(
              title: 'Selfie with ID',
              description: 'Take a selfie holding your ID',
              image: _selfieImage,
              onTap: () => _pickImage(ImageType.selfie),
            ),
            
            const SizedBox(height: 32),
            
            // Submit Button
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitVerification,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('SUBMIT FOR VERIFICATION'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadCard({
    required String title,
    required String description,
    required XFile? image,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    image != null ? Icons.check_circle : Icons.upload_file,
                    color: image != null ? Colors.green : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (image != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(image.path),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

enum ImageType { idFront, idBack, selfie }
