// features/movie/presentation/widgets/movie_widget.dart
import 'package:flutter/material.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';

class MovieWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9).withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          movie.posterPath != null && movie.posterPath.isNotEmpty
              ? Image.network(
                  movie.posterPath,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.grey[300], // Optional: Add a background color
                  child: Icon(
                    Icons.error,
                    size: MediaQuery.of(context).size.width *
                        0.1, // Adjust icon size as needed
                    color: Colors.black,
                  ),
                ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  movie.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
