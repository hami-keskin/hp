import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({Key? key, required this.character}) : super(key: key);

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = character;
    return Scaffold(
      appBar: AppBar(title: Text(c.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (c.image.isNotEmpty)
              Image.network(c.image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            _buildSectionHeader('Genel Bilgiler'),
            _buildRow('ID', c.id),
            _buildRow('İsim', c.name),
            _buildRow('Alternate Names', c.alternateNames.join(', ')),
            _buildRow('Species', c.species),
            _buildRow('Gender', c.gender),
            _buildRow('House', c.house),
            _buildRow('Date of Birth', c.dateOfBirth),
            _buildRow('Year of Birth', c.yearOfBirth.toString()),
            _buildRow('Wizard', c.wizard ? 'Evet' : 'Hayır'),
            _buildRow('Ancestry', c.ancestry),
            _buildRow('Eye Colour', c.eyeColour),
            _buildRow('Hair Colour', c.hairColour),
            _buildSectionHeader('Wand'),
            _buildRow('Wood', c.wand.wood),
            _buildRow('Core', c.wand.core),
            _buildRow('Length', '${c.wand.length} inç'),
            _buildSectionHeader('Ekstra'),
            _buildRow('Patronus', c.patronus),
            _buildRow('Hogwarts Student', c.hogwartsStudent ? 'Evet' : 'Hayır'),
            _buildRow('Hogwarts Staff', c.hogwartsStaff ? 'Evet' : 'Hayır'),
            _buildRow('Actor', c.actor),
            _buildRow('Alternate Actors', c.alternateActors.isEmpty ? '–' : c.alternateActors.join(', ')),
            _buildRow('Alive', c.alive ? 'Evet' : 'Hayır'),
          ],
        ),
      ),
    );
  }
}
