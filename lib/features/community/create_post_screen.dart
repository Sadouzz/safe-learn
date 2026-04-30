import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Ajouter un post",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media Selection
            Row(
              children: [
                // Preview Card
                Stack(
                  children: [
                    // Placeholder gris pour la prévisualisation média
                    Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_outlined,
                            color: AppColors.textMuted,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Aperçu',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        color: Colors.black54,
                        child: const Text(
                          "0:15",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Add Media Button
                Container(
                  width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                      width: 2,
                    ), // Pour des pointillés, utiliser le package 'dotted_border'
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Ajouter une\nPhoto ou Vidéo",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Description
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Un jour inoubliable au skate parc...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "75/220",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Hashtag Input
            const Text(
              "Ajouter un hashtag",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "#skateboard",
                hintStyle: const TextStyle(color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Suggestions
            _buildHashtagSuggestion("#TeamSenegal", "8.3K posts"),
            _buildHashtagSuggestion("#Dakar2026", "13.1K posts"),
            _buildHashtagSuggestion("#Jambars", "5.3K posts"),
            _buildHashtagSuggestion("#FanMoments", "2.6K posts"),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Publier",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHashtagSuggestion(String tag, String posts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tag,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                posts,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
