import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/dhikr.dart';
import '../providers/favorites_provider.dart';

class DhikrCard extends StatefulWidget {
  final String text;
  final String? description;
  final String? reference;
  final int count;

  const DhikrCard({
    super.key,
    required this.text,
    this.description,
    this.reference,
    required this.count,
  });

  @override
  State<DhikrCard> createState() => _DhikrCardState();
}

class _DhikrCardState extends State<DhikrCard> {
  int _remainingCount = 0;

  @override
  void initState() {
    super.initState();
    _remainingCount = widget.count;
  }

  void _decrementCount() {
    if (_remainingCount > 0) {
      setState(() {
        _remainingCount--;
      });
    }
  }

  void _resetCount() {
    setState(() {
      _remainingCount = widget.count;
    });
  }

  void _shareDhikr() {
    String shareText = widget.text;
    if (widget.description != null) {
      shareText += '\n\n${widget.description}';
    }
    if (widget.reference != null) {
      shareText += '\n\n${widget.reference}';
    }
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final dhikr = Dhikr(
      text: widget.text,
      count: widget.count,
      description: widget.description,
    );

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _decrementCount,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.description != null)
                    Text(
                      widget.description!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          favoritesProvider.isFavorite(dhikr)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => favoritesProvider.toggleFavorite(dhikr),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: _shareDhikr,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.text,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              if (widget.reference != null) ...[
                const SizedBox(height: 8),
                Text(
                  widget.reference!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المتبقي: $_remainingCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_remainingCount < widget.count)
                    TextButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة'),
                      onPressed: _resetCount,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
