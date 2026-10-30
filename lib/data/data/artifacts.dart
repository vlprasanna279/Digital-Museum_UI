class Artifact {
  final String name;
  final String civilization;
  final String period;
  final String location;
  final String material;
  final String description;
  final String story;
  final String emoji;

  Artifact({
    required this.name,
    required this.civilization,
    required this.period,
    required this.location,
    required this.material,
    required this.description,
    required this.story,
    required this.emoji,
  });
}

final List<Artifact> artifacts = [
  Artifact(
    name: 'Dancing Girl',
    civilization: 'Indus Valley',
    period: '2500 BCE',
    location: 'Mohenjo-daro',
    material: 'Bronze',
    emoji: '🗿',
    description:
        'A small bronze figurine representing a young woman standing confidently.',
    story:
        'The Dancing Girl is one of the most recognizable artifacts of the Indus Valley Civilization. Its confident posture and detailed craftsmanship provide clues about artistic expression in an ancient urban society.',
  ),
  Artifact(
    name: 'Mask of Tutankhamun',
    civilization: 'Ancient Egypt',
    period: '1323 BCE',
    location: 'Valley of the Kings',
    material: 'Gold',
    emoji: '👑',
    description:
        'The famous funerary mask created for the Egyptian pharaoh Tutankhamun.',
    story:
        'The mask was placed over the head of Tutankhamun during his burial. Made primarily of gold and decorated with precious materials, it became an iconic symbol of ancient Egyptian craftsmanship.',
  ),
  Artifact(
    name: 'Rosetta Stone',
    civilization: 'Ancient Egypt',
    period: '196 BCE',
    location: 'Rosetta',
    material: 'Granodiorite',
    emoji: '📜',
    description:
        'An inscribed stone that helped scholars decipher Egyptian hieroglyphs.',
    story:
        'The Rosetta Stone contains the same decree written in three scripts. Its discovery provided the key that eventually allowed scholars to understand ancient Egyptian hieroglyphs.',
  ),
  Artifact(
    name: 'Terracotta Army',
    civilization: 'Ancient China',
    period: '210 BCE',
    location: 'Xi’an',
    material: 'Terracotta',
    emoji: '⚔️',
    description:
        'Thousands of life-sized clay soldiers created to guard the tomb of Qin Shi Huang.',
    story:
        'The Terracotta Army was created for the first emperor of China. Each figure has distinctive details, creating an enormous underground army intended to accompany the emperor into the afterlife.',
  ),
  Artifact(
    name: 'Bust of Nefertiti',
    civilization: 'Ancient Egypt',
    period: '1345 BCE',
    location: 'Amarna',
    material: 'Limestone',
    emoji: '👸',
    description:
        'A painted limestone bust depicting the Egyptian queen Nefertiti.',
    story:
        'The bust of Nefertiti is celebrated for its elegant proportions and realistic treatment of the human face. It represents the artistic style of Egypt during the Amarna period.',
  ),
  Artifact(
    name: 'Roman Helmet',
    civilization: 'Roman Empire',
    period: '100 CE',
    location: 'Roman Britain',
    material: 'Bronze',
    emoji: '🛡️',
    description:
        'Protective military equipment used by soldiers of the Roman Empire.',
    story:
        'Roman military equipment was designed to provide protection while allowing soldiers to remain mobile. Helmets varied across periods and regions of the empire.',
  ),
];