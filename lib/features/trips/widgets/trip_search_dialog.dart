import 'package:flutter/material.dart';

class TripSearchDialog extends StatefulWidget {
  final Function(String) onSearch;

  const TripSearchDialog({super.key, required this.onSearch});

  @override
  State<TripSearchDialog> createState() => _TripSearchDialogState();
}

class _TripSearchDialogState extends State<TripSearchDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  'Search Trips',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search by title or destination...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              widget.onSearch(value);
            },
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
