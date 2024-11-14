import 'package:flutter/material.dart';

class TopCollectionPage extends StatelessWidget {
  const TopCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCollectionItem(
            'Sale up to 40%',
            'FOR SLIM & BEAUTY',
            'assets/images/top1.png',
          ),
          const SizedBox(height: 16),
          _buildCollectionItem(
            'Summer Collection 2021',
            'Most sexy & fabulous design',
            'assets/images/top2.png',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildGridItem('T-Shirts', 'The Office Life',
                    'assets/images/top3.png', true),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGridItem('Dresses', 'Elegant Design',
                    'assets/images/top4.png', false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionItem(String title, String subtitle, String imagePath) {
    return SizedBox(
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "| $title",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 90,
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      String title, String subtitle, String imagePath, bool check) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          check
              ? ClipRRect(
                  child: Align(
                    alignment:
                        check ? Alignment.centerRight : Alignment.centerLeft,
                    heightFactor: 0.7,
                    widthFactor: 0.55,
                    child: Image.asset(
                      imagePath,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    ClipRRect(
                      child: Align(
                        alignment: check
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        heightFactor: 0.7,
                        widthFactor: 0.55,
                        child: Image.asset(
                          imagePath,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment:
                check ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 280,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
