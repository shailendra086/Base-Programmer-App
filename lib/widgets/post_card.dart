import 'package:baseprogrammer/models/post_model.dart';
import 'package:baseprogrammer/utils/helpers.dart';
import 'package:flutter/material.dart';



class PostCard extends StatelessWidget {
final Post post;
final VoidCallback? onTap;


const PostCard({super.key, required this.post, this.onTap});


@override
Widget build(BuildContext context) {
return Card(
margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
child: InkWell(
onTap: onTap,
child: Padding(
padding: const EdgeInsets.all(10),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildImage(),
const SizedBox(width: 10),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
post.title,
style: const TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 6),
Text(
removeHtmlTags(post.excerpt),
maxLines: 2,
overflow: TextOverflow.ellipsis,
),
const SizedBox(height: 8),
Wrap(
spacing: 6,
children: post.tags
.map((t) => Chip(
label: Text(t),
visualDensity: VisualDensity.compact,
))
.toList(),
)
],
),
)
],
),
),
),
);
}


Widget _buildImage() {
if (post.imageUrl.isEmpty) {
return Container(
width: 90,
height: 70,
color: Colors.grey.shade200,
child: const Icon(Icons.image_not_supported),
);
}


    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        post.imageUrl,
        width: 90,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 90,
          height: 70,
          color: Colors.grey.shade200,
          child: const Icon(Icons.broken_image),
        ),
      ),
    );
}
}