// AETHEL FINAL NETWORK-IMAGE VERSION
// All artifact and achievement images remain internet-hosted.
// Flutter Web uses WebHtmlElementStrategy.prefer for network images
// so Chrome can display cross-origin images when normal fetching is blocked.
// No artifact or badge image needs to be downloaded into the project.
// ============================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const AethelApp());
}


// ============================================================
// MUSEUM STATE
// ============================================================

enum MuseumThemeMode { classic, sepia, night }

class MuseumState extends ChangeNotifier {
  final Set<String> favorites = <String>{};
  final Set<String> viewedArtifacts = <String>{};

  MuseumThemeMode themeMode = MuseumThemeMode.classic;
  int quizBestScore = 0;
  bool quizCompleted = false;

  bool isFavorite(String artifactName) => favorites.contains(artifactName);

  void toggleFavorite(String artifactName) {
    if (favorites.contains(artifactName)) {
      favorites.remove(artifactName);
    } else {
      favorites.add(artifactName);
    }
    notifyListeners();
  }

  void markViewed(String artifactName) {
    viewedArtifacts.add(artifactName);
  }

  void setTheme(MuseumThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void recordQuiz(int score) {
    if (score > quizBestScore) {
      quizBestScore = score;
    }
    quizCompleted = true;
    notifyListeners();
  }
}

final MuseumState museumState = MuseumState();

// ============================================================
// APP
// ============================================================

class AethelApp extends StatelessWidget {
  const AethelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aethel Digital Museum',
          theme: _themeFor(museumState.themeMode),
          builder: (context, child) {
            final mode = museumState.themeMode;
            if (mode == MuseumThemeMode.classic) {
              return child!;
            }

            return ColorFiltered(
              colorFilter: mode == MuseumThemeMode.sepia
                  ? const ColorFilter.matrix(<double>[
                      0.45, 0.30, 0.15, 0, 25,
                      0.25, 0.55, 0.20, 0, 20,
                      0.10, 0.25, 0.65, 0, 10,
                      0, 0, 0, 1, 0,
                    ])
                  : const ColorFilter.matrix(<double>[
                      -0.72, -0.72, -0.72, 0, 255,
                      -0.72, -0.72, -0.72, 0, 255,
                      -0.72, -0.72, -0.72, 0, 255,
                      0, 0, 0, 1, 0,
                    ]),
              child: child!,
            );
          },
          home: const HomePage(),
        );
      },
    );
  }
}


ThemeData _themeFor(MuseumThemeMode mode) {
  switch (mode) {
    case MuseumThemeMode.night:
      return ThemeData(
        scaffoldBackgroundColor: const Color(0xFF171512),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC49A62),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Georgia',
        useMaterial3: true,
      );
    case MuseumThemeMode.sepia:
      return ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE7D5B8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF795548),
        ),
        fontFamily: 'Georgia',
        useMaterial3: true,
      );
    case MuseumThemeMode.classic:
      return ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4EFE6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B6F47),
        ),
        fontFamily: 'Georgia',
        useMaterial3: true,
      );
  }
}

// ============================================================
// ARTIFACT MODEL
// ============================================================

class Artifact {
  final String country;
  final String name;
  final String period;
  final String material;
  final String image;
  final String description;

  const Artifact({
    required this.country,
    required this.name,
    required this.period,
    required this.material,
    required this.image,
    required this.description,
  });
}

// ============================================================
// ARTIFACT DATA
// ============================================================

final List<Artifact> allArtifacts = [
  // ---------------- INDIA ----------------

  Artifact(
    country: 'India',
    name: 'Dancing Girl',
    period: 'c. 2500 BCE',
    material: 'Bronze',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Dancing%20girl%20of%20Mohenjo-daro.jpg',
    description:
        'The Dancing Girl is one of the most famous objects discovered at Mohenjo-daro, a major city of the Indus Valley Civilization. Created around 2500 BCE, this small bronze figure represents a young girl standing confidently with one hand resting on her hip. The sculpture was made using the lost-wax casting technique, demonstrating the advanced metalworking abilities of the civilization. Her relaxed posture and confident expression give the figure a remarkable sense of movement and personality. The Dancing Girl provides important evidence about artistic traditions and metalworking technology in the ancient Indus Valley.',
  ),

  Artifact(
    country: 'India',
    name: 'Ashoka Lion Capital',
    period: 'c. 250 BCE',
    material: 'Sandstone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Lion%20capital%20of%20Ashoka%2C%20Sarnath.jpg',
    description:
        'The Lion Capital of Ashoka was created during the reign of Emperor Ashoka of the Mauryan Empire around the 3rd century BCE. It originally stood at Sarnath, an important Buddhist site associated with the Buddha. The capital consists of four lions standing back-to-back above a circular abacus decorated with animals and a Dharma Chakra. Carved from polished sandstone, it demonstrates the exceptional craftsmanship of the Mauryan period. The Lion Capital is now the official State Emblem of India and remains one of the most important symbols of Indian history.',
  ),

  Artifact(
    country: 'India',
    name: 'Sanchi Stupa',
    period: '3rd century BCE',
    material: 'Stone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Sanchi%20stupa%20001.jpg',
    description:
        'The Great Stupa at Sanchi is one of the oldest surviving stone structures in India and an important monument of Buddhist architecture. It was originally commissioned by Emperor Ashoka during the 3rd century BCE and was later enlarged and decorated. The hemispherical dome represents the Buddha and the Buddhist universe. Four elaborately carved gateways depict stories from the Buddha’s life and scenes from everyday society. Sanchi provides valuable evidence about the development of Buddhist art, architecture, and religious traditions in ancient India.',
  ),

  // ---------------- EGYPT ----------------

  Artifact(
    country: 'Egypt',
    name: 'Mask of Tutankhamun',
    period: 'c. 1323 BCE',
    material: 'Gold',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Mask%20of%20Tutankhamun%202003-12-07.jpg',
    description:
        'The funerary mask of Tutankhamun is one of the most recognizable objects from ancient Egypt. It was discovered in the pharaoh’s tomb in the Valley of the Kings in 1922 by Howard Carter. The mask was created from gold and decorated with colored glass and precious stones. Its idealized face represents the young king as a divine ruler prepared for the afterlife. The mask demonstrates the extraordinary craftsmanship, religious beliefs, and wealth of the Egyptian New Kingdom.',
  ),

  Artifact(
    country: 'Egypt',
    name: 'Rosetta Stone',
    period: '196 BCE',
    material: 'Granodiorite',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/The%20Rosetta%20Stone.jpg',
    description:
        'The Rosetta Stone is a fragment of a larger ancient Egyptian decree created in 196 BCE. It contains the same text written in three scripts: Egyptian hieroglyphs, Demotic, and Ancient Greek. Its discovery by French soldiers in 1799 provided scholars with the key needed to decipher Egyptian hieroglyphs. The stone therefore played a major role in understanding ancient Egyptian writing and history. It remains one of the most significant archaeological discoveries in the study of ancient civilizations.',
  ),

  Artifact(
    country: 'Egypt',
    name: 'Bust of Nefertiti',
    period: 'c. 1345 BCE',
    material: 'Limestone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Nofretete%20Neues%20Museum.jpg',
    description:
        'The Bust of Nefertiti is an ancient Egyptian painted limestone sculpture depicting Queen Nefertiti, the wife of Pharaoh Akhenaten. It was created around 1345 BCE during the Amarna Period, a time of major religious and artistic change. The sculpture is notable for its balanced proportions, elegant features, and remaining traces of colorful paint. It was discovered at the workshop of the sculptor Thutmose at Amarna in 1912. The bust has become an enduring symbol of ancient Egyptian artistic achievement.',
  ),

  // ---------------- GREECE ----------------

  Artifact(
    country: 'Greece',
    name: 'Mask of Agamemnon',
    period: 'c. 16th century BCE',
    material: 'Gold',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Mask%20of%20Agamemnon.jpg',
    description:
        'The Mask of Agamemnon is a famous gold funerary mask discovered at Mycenae by Heinrich Schliemann in 1876. It was found within a royal burial circle and was initially associated with the legendary Greek king Agamemnon. Modern scholarship suggests that the mask predates the traditional date of the Trojan War and therefore may not depict Agamemnon himself. The finely worked gold sheet demonstrates the wealth and craftsmanship of the Mycenaean civilization. The mask remains an important object for understanding Bronze Age Greece.',
  ),

  Artifact(
    country: 'Greece',
    name: 'Venus de Milo',
    period: 'c. 130–100 BCE',
    material: 'Marble',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Venus%20de%20Milo.jpg',
    description:
        'The Venus de Milo is a famous ancient Greek marble sculpture believed to represent Aphrodite, the goddess of love and beauty. It was created during the Hellenistic period and discovered on the Greek island of Milos in 1820. The statue is known for its graceful pose, idealized human proportions, and partially preserved drapery. Although both arms are missing, the sculpture remains one of the most celebrated works of classical art. It demonstrates the Hellenistic interest in beauty, movement, and natural human form.',
  ),

  Artifact(
    country: 'Greece',
    name: 'Discobolus',
    period: 'c. 460–450 BCE',
    material: 'Marble copy of bronze original',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Discobulus.jpg',
    description:
        'The Discobolus, or Discus Thrower, is a famous representation of an athlete preparing to throw a discus. The original bronze sculpture was created by the Greek sculptor Myron during the Classical period. The original has been lost, but several Roman marble copies survive. The sculpture captures the human body in a carefully balanced moment of movement and physical tension. It is an important example of the Greek interest in ideal human proportions, athleticism, and controlled movement.',
  ),

  // ---------------- CHINA ----------------

  Artifact(
    country: 'China',
    name: 'Terracotta Army',
    period: '3rd century BCE',
    material: 'Terracotta',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Terracotta%20Army%20%2854081680992%29.jpg',
    description:
        'The Terracotta Army is a vast collection of life-sized clay soldiers created to protect the tomb of Qin Shi Huang, the first emperor of unified China. The figures were buried around 210 BCE near modern Xi’an. Thousands of soldiers, horses, chariots, and weapons were arranged in military formations. Each figure displays individual facial features, hairstyles, clothing, and positions. The discovery provides extraordinary evidence of the organization, military technology, artistic skill, and imperial power of ancient China.',
  ),

  Artifact(
    country: 'China',
    name: 'Jade Burial Suit',
    period: '2nd century BCE',
    material: 'Jade and Gold Wire',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/JadeBurialSuit.JPG',
    description:
        'Jade burial suits were created for members of the Han dynasty elite and were believed to protect the body after death. Thousands of pieces of jade were carefully cut and connected using gold, silver, copper, or silk thread depending on the rank of the individual. Jade held strong spiritual and symbolic significance in ancient Chinese culture. The suits demonstrate the wealth and sophisticated craftsmanship of the Han dynasty. They also reveal important beliefs concerning death, preservation, and the afterlife.',
  ),

  Artifact(
    country: 'China',
    name: 'Bronze Ding Vessel',
    period: 'c. 1000 BCE',
    material: 'Bronze',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/CMOC%20Treasures%20of%20Ancient%20China%20exhibit%20-%20bronze%20ding%20of%20Ren.jpg',
    description:
        'The bronze ding was an important ritual vessel used in ancient China, particularly during the Shang and Zhou dynasties. It was commonly used in ceremonies and associated with political authority and ancestral worship. Ding vessels were produced using advanced bronze-casting techniques and often carried elaborate decorative patterns. Their possession could represent social rank and political power. Bronze ritual vessels therefore provide important evidence about the religious and political structure of early Chinese civilization.',
  ),

  // ---------------- ITALY ----------------

  Artifact(
    country: 'Italy',
    name: 'Colosseum',
    period: '80 CE',
    material: 'Concrete and Stone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Colosseum%20-%20Rome.jpg',
    description:
        'The Colosseum is one of the greatest surviving monuments of ancient Rome. Construction began under Emperor Vespasian and the amphitheater was officially opened by Emperor Titus around 80 CE. It could accommodate tens of thousands of spectators and hosted gladiatorial contests, animal hunts, and public spectacles. Its complex system of arches, corridors, seating areas, and underground structures demonstrates the engineering capabilities of the Roman Empire. The Colosseum remains a powerful symbol of Roman architecture and public entertainment.',
  ),

  Artifact(
    country: 'Italy',
    name: 'Augustus of Prima Porta',
    period: '1st century CE',
    material: 'Marble',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Augustus%20of%20Prima%20Porta.jpg',
    description:
        'Augustus of Prima Porta is a famous marble statue portraying the first Roman emperor, Augustus, as a powerful military and political leader. The statue was discovered in 1863 at the Villa of Livia near Rome. Augustus is shown wearing elaborate military armor decorated with symbolic scenes. A small Cupid figure near his leg connects him with the goddess Venus and emphasizes his divine ancestry. The sculpture demonstrates how Roman art was used to communicate political authority, military success, and imperial ideology.',
  ),

  Artifact(
    country: 'Italy',
    name: 'Roman Mosaic',
    period: '1st–4th century CE',
    material: 'Stone and Glass Tesserae',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Roman%20Mosaic%20from%20Pompeii%20%2848451774052%29.jpg',
    description:
        'Roman mosaics were decorative artworks created by arranging thousands of small pieces called tesserae into detailed patterns and images. They were commonly used to decorate floors and walls in wealthy Roman homes, villas, baths, and public buildings. Artists could create geometric patterns, portraits, mythological scenes, and images of animals and daily life. The durability of mosaic materials has allowed many examples to survive for centuries. Roman mosaics provide valuable information about Roman art, architecture, mythology, and everyday culture.',
  ),

  // ---------------- MEXICO ----------------

  Artifact(
    country: 'Mexico',
    name: 'Aztec Sun Stone',
    period: 'c. 1500s CE',
    material: 'Stone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Reproduction%20of%20Aztec%20Sun%20Stone.jpg',
    description:
        'The Aztec Sun Stone is a monumental carved stone associated with the Mexica or Aztec civilization. It was created during the late 15th or early 16th century and contains complex symbols representing Aztec concepts of time and cosmology. At its center is the face of a deity surrounded by concentric rings of calendrical and religious imagery. The enormous stone demonstrates the mathematical, astronomical, and artistic knowledge of Aztec society. It has become one of the most recognizable symbols of pre-Columbian Mexico.',
  ),

  Artifact(
    country: 'Mexico',
    name: 'Chacmool',
    period: 'c. 900–1200 CE',
    material: 'Stone',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Chac%20mool.jpg',
    description:
        'A Chacmool is a distinctive reclining stone sculpture found at several Mesoamerican archaeological sites. The figure is usually shown lying on its back with its head turned to one side and its hands resting over the abdomen. A shallow bowl or tray is often placed on the stomach and may have been associated with ritual offerings. Examples are particularly well known from sites such as Chichen Itza. These sculptures provide evidence of religious ceremonies and artistic traditions in ancient Mesoamerican cultures.',
  ),

  Artifact(
    country: 'Mexico',
    name: 'Maya Mask',
    period: 'c. 600–900 CE',
    material: 'Jade',
    image: 'https://commons.wikimedia.org/wiki/Special:Redirect/file/MayaCampecheMask1.JPG',
    description:
        'Maya jade masks were prestigious objects created for important rulers and individuals, particularly during the Classic Maya period. Jade was highly valued because of its color, durability, and spiritual associations. Masks were often placed in burials and could represent rulers, deities, or supernatural beings. Their carefully carved features and polished surfaces demonstrate the exceptional craftsmanship of Maya artists. These objects reveal the importance of religion, rulership, death, and the afterlife in Maya society.',
  ),
];

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 850;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 55 : 24,
                  vertical: isWide ? 35 : 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'AETHEL',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                            color: Color(0xFF302A24),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4C5B2),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'EST. 2026',
                            style: TextStyle(
                              fontSize: 9,
                              letterSpacing: 1.8,
                              color: Color(0xFF8B6F47),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isWide ? 70 : 45),

                    // HERO SECTION
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _HomeIntro(isWide: true),
                          ),
                          const SizedBox(width: 70),
                          Expanded(
                            flex: 4,
                            child: _MuseumDisplay(),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _HomeIntro(isWide: false),
                          const SizedBox(height: 40),
                          _MuseumDisplay(),
                        ],
                      ),

                    SizedBox(height: isWide ? 80 : 60),

                    // COLLECTION SECTION
                    const Text(
                      'THE COLLECTION',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B6F47),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Stories beyond the display.',
                      style: TextStyle(
                        fontSize: isWide ? 30 : 25,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF302A24),
                      ),
                    ),

                    const SizedBox(height: 25),

                    if (isWide)
                      const Row(
                        children: [
                          Expanded(
                            child: _CollectionCard(
                              icon: Icons.account_balance_outlined,
                              title: 'CIVILIZATIONS',
                              text:
                                  'Journey through cultures that shaped the ancient world.',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _CollectionCard(
                              icon: Icons.auto_awesome_outlined,
                              title: 'ART & OBJECTS',
                              text:
                                  'Discover sculptures, monuments, vessels, and treasured works.',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _CollectionCard(
                              icon: Icons.menu_book_outlined,
                              title: 'HISTORY',
                              text:
                                  'Explore the stories and context behind every artifact.',
                            ),
                          ),
                        ],
                      )
                    else
                      const Column(
                        children: [
                          _CollectionCard(
                            icon: Icons.account_balance_outlined,
                            title: 'CIVILIZATIONS',
                            text:
                                'Journey through cultures that shaped the ancient world.',
                          ),
                          SizedBox(height: 14),
                          _CollectionCard(
                            icon: Icons.auto_awesome_outlined,
                            title: 'ART & OBJECTS',
                            text:
                                'Discover sculptures, monuments, vessels, and treasured works.',
                          ),
                          SizedBox(height: 14),
                          _CollectionCard(
                            icon: Icons.menu_book_outlined,
                            title: 'HISTORY',
                            text:
                                'Explore the stories and context behind every artifact.',
                          ),
                        ],
                      ),

                    const SizedBox(height: 55),

                    const MuseumToolsSection(),

                    const SizedBox(height: 55),

                    // FOOTER
                    const Center(
                      child: Text(
                        'DISCOVER  •  LEARN  •  REMEMBER',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 2.5,
                          color: Color(0xFF8B6F47),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// ============================================================
// HOME INTRO
// ============================================================

class _HomeIntro extends StatelessWidget {
  final bool isWide;

  const _HomeIntro({
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Text(
          'A DIGITAL COLLECTION',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B6F47),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'DIGITAL\nMUSEUM',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 64 : 48,
            height: 0.98,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: const Color(0xFF302A24),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Explore the stories that shaped civilizations.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 20 : 17,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF62574D),
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          width: isWide ? 520 : 500,
          child: Text(
            'A curated digital journey through art, culture, '
            'architecture, and extraordinary objects from the ancient world.',
            textAlign: isWide ? TextAlign.left : TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.7,
              color: Color(0xFF74695F),
            ),
          ),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: 245,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CountriesPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_forward,
              size: 17,
            ),
            label: const Text(
              'EXPLORE THE MUSEUM',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF302A24),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// ============================================================
// MUSEUM DISPLAY
// ============================================================

class _MuseumDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 850;

    return Container(
      width: double.infinity,
      height: isWide ? 390 : 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DED0),
        border: Border.all(
          color: const Color(0xFFD4C5B2),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF4EFE6),
          border: Border.all(
            color: const Color(0xFFD4C5B2),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 18,
              left: 18,
              child: Text(
                '01',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  color: const Color(0xFF8B6F47),
                ),
              ),
            ),

            Positioned(
              bottom: 18,
              right: 18,
              child: Text(
                'AETHEL',
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: const Color(0xFF8B6F47),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF8B6F47),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      size: 55,
                      color: Color(0xFF8B6F47),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'AETHEL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                      color: Color(0xFF302A24),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'HISTORY  •  ART  •  CULTURE',
                    style: TextStyle(
                      fontSize: 8,
                      letterSpacing: 2,
                      color: Color(0xFF74695F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// COLLECTION CARD
// ============================================================

class _CollectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _CollectionCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EE),
        border: Border.all(
          color: const Color(0xFFD4C5B2),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE4D7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              icon,
              size: 21,
              color: const Color(0xFF8B6F47),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF302A24),
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: Color(0xFF74695F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// MUSEUM TOOLS
// ============================================================

class MuseumToolsSection extends StatelessWidget {
  const MuseumToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width >= 900 ? 3 : width >= 600 ? 2 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MUSEUM TOOLS',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B6F47),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Explore Aethel your way.',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Color(0xFF302A24),
          ),
        ),
        const SizedBox(height: 22),
        GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: width < 600 ? 3.2 : 2.1,
          children: const [
            _ToolCard(
              icon: Icons.favorite_outline,
              title: 'FAVOURITES',
              subtitle: 'Save artifacts to your collection.',
              page: _ToolPage.favorites,
            ),
            _ToolCard(
              icon: Icons.public_outlined,
              title: 'WORLD MAP',
              subtitle: 'Explore civilizations by location.',
              page: _ToolPage.map,
            ),
            _ToolCard(
              icon: Icons.brightness_6_outlined,
              title: '3 DISPLAY MODES',
              subtitle: 'Classic, Sepia, or Night.',
              page: _ToolPage.theme,
            ),
            _ToolCard(
              icon: Icons.workspace_premium_outlined,
              title: 'ACHIEVEMENTS',
              subtitle: 'Unlock museum badges.',
              page: _ToolPage.badges,
            ),
            _ToolCard(
              icon: Icons.insights_outlined,
              title: 'MY PROGRESS',
              subtitle: 'Track your museum journey.',
              page: _ToolPage.progress,
            ),
            _ToolCard(
              icon: Icons.quiz_outlined,
              title: 'MUSEUM QUIZ',
              subtitle: 'Test what you discovered.',
              page: _ToolPage.quiz,
            ),
          ],
        ),
      ],
    );
  }
}

enum _ToolPage { favorites, map, theme, badges, progress, quiz }

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final _ToolPage page;

  const _ToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  void _open(BuildContext context) {
    Widget destination;
    switch (page) {
      case _ToolPage.favorites:
        destination = const FavoritesPage();
        break;
      case _ToolPage.map:
        destination = const WorldMapPage();
        break;
      case _ToolPage.theme:
        destination = const DisplayModePage();
        break;
      case _ToolPage.badges:
        destination = const AchievementsPage();
        break;
      case _ToolPage.progress:
        destination = const ProgressPage();
        break;
      case _ToolPage.quiz:
        destination = const QuizPage();
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F5EE),
          border: Border.all(color: const Color(0xFFD4C5B2)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE4D7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                size: 21,
                color: const Color(0xFF8B6F47),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 9,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF302A24),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: Color(0xFF74695F),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Color(0xFF8B6F47),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FAVOURITES PAGE
// ============================================================

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        final favorites = allArtifacts
            .where((artifact) => museumState.isFavorite(artifact.name))
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favourites',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xFFF4EFE6),
            foregroundColor: const Color(0xFF302A24),
            elevation: 0,
          ),
          body: favorites.isEmpty
              ? const _EmptyState(
                  icon: Icons.favorite_border,
                  title: 'Your collection is empty',
                  message:
                      'Open an artifact and tap the heart to save it here.',
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(22),
                  itemCount: favorites.length,
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 340,
                    mainAxisExtent: 420,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),
                  itemBuilder: (context, index) =>
                      _ArtifactCard(artifact: favorites[index]),
                ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: const Color(0xFF8B6F47)),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF302A24),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF74695F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// AETHEL WORLD MAP
// ============================================================

class WorldMapPage extends StatelessWidget {
  const WorldMapPage({super.key});

  static const String worldMapUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/'
      'Blank_world_map_Equal_Earth_projection.svg/'
      '1280px-Blank_world_map_Equal_Earth_projection.svg.png';

  void _openCountry(BuildContext context, String country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArtifactsPage(country: country),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE6),

      appBar: AppBar(
        title: const Text(
          'World Map',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 35),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'EXPLORE BY LOCATION',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 3,
                      color: Color(0xFF8B6F47),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'The Aethel World Map',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF302A24),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Explore the civilizations represented in the museum.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF74695F),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // MAP
                  // ==================================================

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8DED0),
                      border: Border.all(
                        color: const Color(0xFFD4C5B2),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: LayoutBuilder(
                        builder: (context, constraints) {

                          final mapWidth = constraints.maxWidth;
                          final mapHeight = mapWidth / 2.05;

                          return SizedBox(
                            height: mapHeight,

                            child: Stack(
                              children: [

                                // REAL WORLD MAP
                                Positioned.fill(
                                  child: Image.network(
                                    worldMapUrl,
                                    fit: BoxFit.contain,

                                    loadingBuilder:
                                        (context, child, progress) {
                                      if (progress == null) {
                                        return child;
                                      }

                                      return const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFF8B6F47),
                                        ),
                                      );
                                    },

                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return const Center(
                                        child: Text(
                                          'World map could not be loaded.',
                                          style: TextStyle(
                                            color: Color(0xFF74695F),
                                          ),
                                        ),
                                      );
                                    },

                                    webHtmlElementStrategy:
                                        WebHtmlElementStrategy.prefer,
                                  ),
                                ),

                                // ==================================================
                                // MEXICO
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'Mexico',
                                  left: mapWidth * 0.17,
                                  top: mapHeight * 0.48,
                                  onTap: () =>
                                      _openCountry(context, 'Mexico'),
                                ),

                                // ==================================================
                                // ITALY
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'Italy',
                                  left: mapWidth * 0.475,
                                  top: mapHeight * 0.32,
                                  onTap: () =>
                                      _openCountry(context, 'Italy'),
                                ),

                                // ==================================================
                                // GREECE
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'Greece',
                                  left: mapWidth * 0.515,
                                  top: mapHeight * 0.37,
                                  onTap: () =>
                                      _openCountry(context, 'Greece'),
                                ),

                                // ==================================================
                                // EGYPT
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'Egypt',
                                  left: mapWidth * 0.535,
                                  top: mapHeight * 0.43,
                                  onTap: () =>
                                      _openCountry(context, 'Egypt'),
                                ),

                                // ==================================================
                                // INDIA
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'India',
                                  left: mapWidth * 0.655,
                                  top: mapHeight * 0.43,
                                  onTap: () =>
                                      _openCountry(context, 'India'),
                                ),

                                // ==================================================
                                // CHINA
                                // ==================================================

                                _mapButton(
                                  context,
                                  country: 'China',
                                  left: mapWidth * 0.705,
                                  top: mapHeight * 0.32,
                                  onTap: () =>
                                      _openCountry(context, 'China'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // COLLECTION COUNT
                  // ==================================================

                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8DED0),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFD4C5B2),
                        ),
                      ),
                      child: const Text(
                        '6 CIVILIZATIONS  •  18 ARTIFACTS',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF74695F),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // COUNTRY NAVIGATION
                  // ==================================================

                  const Text(
                    'EXPLORE COLLECTIONS',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B6F47),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [

                      _countryChip(
                        context,
                        'India',
                        () => _openCountry(context, 'India'),
                      ),

                      _countryChip(
                        context,
                        'Egypt',
                        () => _openCountry(context, 'Egypt'),
                      ),

                      _countryChip(
                        context,
                        'Greece',
                        () => _openCountry(context, 'Greece'),
                      ),

                      _countryChip(
                        context,
                        'China',
                        () => _openCountry(context, 'China'),
                      ),

                      _countryChip(
                        context,
                        'Italy',
                        () => _openCountry(context, 'Italy'),
                      ),

                      _countryChip(
                        context,
                        'Mexico',
                        () => _openCountry(context, 'Mexico'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MAP BUTTON
  // ============================================================

  Widget _mapButton(
    BuildContext context, {
    required String country,
    required double left,
    required double top,
    required VoidCallback onTap,
  }) {
    return Positioned(
      left: left,
      top: top,

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),

          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFF9F5EE),
              borderRadius: BorderRadius.circular(22),

              border: Border.all(
                color: const Color(0xFF9B7A4A),
                width: 1.2,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Icon(
                  Icons.location_on,
                  size: 13,
                  color: Color(0xFF8B6F47),
                ),

                const SizedBox(width: 5),

                Text(
                  country,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Color(0xFF302A24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // COUNTRY CHIP LIST
  // ============================================================

  Widget _countryChip(
    BuildContext context,
    String country,
    VoidCallback onTap,
  ) {
    return OutlinedButton.icon(
      onPressed: onTap,

      icon: const Icon(
        Icons.location_on_outlined,
        size: 15,
      ),

      label: Text(country),

      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF302A24),
        backgroundColor: const Color(0xFFF9F5EE),

        side: const BorderSide(
          color: Color(0xFFD4C5B2),
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 11,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}

// ============================================================
// DISPLAY MODES
// ============================================================

class DisplayModePage extends StatelessWidget {
  const DisplayModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Display Modes',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const Text(
            'CHOOSE YOUR EXPERIENCE',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              color: Color(0xFF8B6F47),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Three display modes',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF302A24),
            ),
          ),
          const SizedBox(height: 25),
          _ModeTile(
            mode: MuseumThemeMode.classic,
            icon: Icons.wb_sunny_outlined,
            title: 'CLASSIC',
            subtitle: 'The original warm museum palette.',
          ),
          const SizedBox(height: 12),
          _ModeTile(
            mode: MuseumThemeMode.sepia,
            icon: Icons.history_edu_outlined,
            title: 'SEPIA',
            subtitle: 'A warmer archival-paper atmosphere.',
          ),
          const SizedBox(height: 12),
          _ModeTile(
            mode: MuseumThemeMode.night,
            icon: Icons.nights_stay_outlined,
            title: 'NIGHT',
            subtitle: 'A darker viewing experience.',
          ),
        ],
      ),
    );
  }
}

class _ModeTile extends StatelessWidget {
  final MuseumThemeMode mode;
  final IconData icon;
  final String title;
  final String subtitle;

  const _ModeTile({
    required this.mode,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        final selected = museumState.themeMode == mode;
        return InkWell(
          onTap: () => museumState.setTheme(mode),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFE8DED0)
                  : const Color(0xFFF9F5EE),
              border: Border.all(
                color: selected
                    ? const Color(0xFF8B6F47)
                    : const Color(0xFFD4C5B2),
                width: selected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF8B6F47), size: 27),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF302A24),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF74695F),
                        ),
                      ),
                    ],
                  ),
                ),
                if (selected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF8B6F47),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// PROGRESS PAGE
// ============================================================

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        final viewed = museumState.viewedArtifacts.length;
        final total = allArtifacts.length;
        final progress = viewed / total;
        final countriesVisited = {
          for (final artifact in allArtifacts)
            if (museumState.viewedArtifacts.contains(artifact.name))
              artifact.country,
        }.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Progress',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xFFF4EFE6),
            foregroundColor: const Color(0xFF302A24),
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              const Text(
                'YOUR JOURNEY',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                  color: Color(0xFF8B6F47),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Museum progress',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF302A24),
                ),
              ),
              const SizedBox(height: 30),
              _ProgressStat(
                label: 'ARTIFACTS EXPLORED',
                value: '$viewed / $total',
                progress: progress,
              ),
              const SizedBox(height: 18),
              _ProgressStat(
                label: 'CIVILIZATIONS VISITED',
                value: '$countriesVisited / 6',
                progress: countriesVisited / 6,
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F5EE),
                  border: Border.all(color: const Color(0xFFD4C5B2)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.quiz_outlined,
                      color: Color(0xFF8B6F47),
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Quiz status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF302A24),
                        ),
                      ),
                    ),
                    Text(
                      museumState.quizCompleted
                          ? 'Best: ${museumState.quizBestScore}/5'
                          : 'Not attempted',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF74695F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressStat extends StatelessWidget {
  final String label;
  final String value;
  final double progress;

  const _ProgressStat({
    required this.label,
    required this.value,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final safeProgress = progress.clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5EE),
        border: Border.all(color: const Color(0xFFD4C5B2)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.5,
                  color: Color(0xFF8B6F47),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF302A24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: safeProgress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE1D5C7),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF8B6F47),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ACHIEVEMENTS
// ============================================================

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        final viewed = museumState.viewedArtifacts.length;
        final badges = [
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/medal.png',
            title: 'FIRST LOOK',
            description: 'Explore your first artifact.',
            unlocked: viewed >= 1,
          ),
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/treasure-chest.png',
            title: 'COLLECTOR',
            description: 'Save three artifacts as favourites.',
            unlocked: museumState.favorites.length >= 3,
          ),
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/globe--v1.png',
            title: 'WORLD TRAVELLER',
            description: 'Visit artifacts from three civilizations.',
            unlocked: {
              for (final artifact in allArtifacts)
                if (museumState.viewedArtifacts.contains(artifact.name))
                  artifact.country,
            }.length >= 3,
          ),
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/books.png',
            title: 'SCHOLAR',
            description: 'Explore ten artifacts.',
            unlocked: viewed >= 10,
          ),
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/museum.png',
            title: 'CURATOR',
            description: 'Complete the museum quiz.',
            unlocked: museumState.quizCompleted,
          ),
          _Badge(
            imageUrl: 'https://img.icons8.com/color/480/crown.png',
            title: 'MUSEUM MASTER',
            description: 'Explore every artifact.',
            unlocked: viewed == allArtifacts.length,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Achievements',
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xFFF4EFE6),
            foregroundColor: const Color(0xFF302A24),
            elevation: 0,
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(22),
            itemCount: badges.length,
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisExtent: 215,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _BadgeCard(badge: badges[index]);
            },
          ),
        );
      },
    );
  }
}

class _Badge {
  final String imageUrl;
  final String title;
  final String description;
  final bool unlocked;

  const _Badge({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.unlocked,
  });
}

class _BadgeCard extends StatelessWidget {
  final _Badge badge;

  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: badge.unlocked
            ? const Color(0xFFF9F5EE)
            : const Color(0xFFE8DED0),
        border: Border.all(
          color: badge.unlocked
              ? const Color(0xFFB28A4A)
              : const Color(0xFFD4C5B2),
          width: badge.unlocked ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: badge.unlocked
            ? [
                BoxShadow(
                  color: const Color(0xFFE2B86A).withOpacity(0.35),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 82,
            height: 82,
            child: Opacity(
              opacity: badge.unlocked ? 1.0 : 0.35,
              child: Image.network(
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                badge.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.workspace_premium_outlined,
                    size: 55,
                    color: badge.unlocked
                        ? const Color(0xFFE2B86A)
                        : const Color(0xFF9D9286),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            badge.title,
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: badge.unlocked
                  ? const Color(0xFF302A24)
                  : const Color(0xFF74695F),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badge.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.35,
              color: Color(0xFF74695F),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            badge.unlocked ? 'UNLOCKED' : 'LOCKED',
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 1.5,
              color: badge.unlocked
                  ? const Color(0xFF8B6F47)
                  : const Color(0xFF9D9286),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QUIZ
// ============================================================

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool quizFinished = false;

  final List<_QuizQuestion> questions = const [
    _QuizQuestion(
      question: 'Which artifact was discovered at Mohenjo-daro?',
      options: [
        'Dancing Girl',
        'Rosetta Stone',
        'Discobolus',
        'Chacmool',
      ],
      answer: 0,
    ),
    _QuizQuestion(
      question: 'What material is the Mask of Tutankhamun made primarily from?',
      options: ['Marble', 'Gold', 'Jade', 'Bronze'],
      answer: 1,
    ),
    _QuizQuestion(
      question: 'The Rosetta Stone helped scholars understand which writing?',
      options: [
        'Cuneiform',
        'Latin',
        'Egyptian hieroglyphs',
        'Sanskrit',
      ],
      answer: 2,
    ),
    _QuizQuestion(
      question: 'The Terracotta Army was created for which ruler?',
      options: [
        'Ashoka',
        'Augustus',
        'Qin Shi Huang',
        'Akhenaten',
      ],
      answer: 2,
    ),
    _QuizQuestion(
      question: 'The Colosseum is an important monument of which civilization?',
      options: ['Roman', 'Maya', 'Mycenaean', 'Han Chinese'],
      answer: 0,
    ),
  ];

  void _submitAnswer() {
    if (selectedAnswer == null) return;

    if (selectedAnswer == questions[questionIndex].answer) {
      score++;
    }

    if (questionIndex == questions.length - 1) {
      museumState.recordQuiz(score);
      setState(() {
        quizFinished = true;
      });
    } else {
      setState(() {
        questionIndex++;
        selectedAnswer = null;
      });
    }
  }

  void _restart() {
    setState(() {
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Museum Quiz',
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xFFF4EFE6),
          foregroundColor: const Color(0xFF302A24),
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.workspace_premium_outlined,
                  size: 75,
                  color: Color(0xFF8B6F47),
                ),
                const SizedBox(height: 20),
                const Text(
                  'QUIZ COMPLETE',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 3,
                    color: Color(0xFF8B6F47),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$score / ${questions.length}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF302A24),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  score == questions.length
                      ? 'Perfect collection knowledge.'
                      : 'Your museum journey continues.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF74695F),
                  ),
                ),
                const SizedBox(height: 25),
                OutlinedButton.icon(
                  onPressed: _restart,
                  icon: const Icon(Icons.refresh),
                  label: const Text('TRY AGAIN'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final question = questions[questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Museum Quiz',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Text(
            'QUESTION ${questionIndex + 1} OF ${questions.length}',
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 2.5,
              color: Color(0xFF8B6F47),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 27,
              height: 1.25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF302A24),
            ),
          ),
          const SizedBox(height: 28),
          ...List.generate(
            question.options.length,
            (index) {
              final selected = selectedAnswer == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => setState(() {
                    selectedAnswer = index;
                  }),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFE8DED0)
                          : const Color(0xFFF9F5EE),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF8B6F47)
                            : const Color(0xFFD4C5B2),
                        width: selected ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: const Color(0xFF8B6F47),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF302A24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: selectedAnswer == null ? null : _submitAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF302A24),
                foregroundColor: Colors.white,
              ),
              child: Text(
                questionIndex == questions.length - 1
                    ? 'FINISH QUIZ'
                    : 'NEXT QUESTION',
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int answer;

  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}

// ============================================================
// COUNTRIES PAGE
// ============================================================

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  final List<Map<String, String>> countries = const [
    {
      'name': 'India',
      'flag': '🇮🇳',
      'description': 'Indus Valley • Mauryan • Buddhist',
    },
    {
      'name': 'Egypt',
      'flag': '🇪🇬',
      'description': 'Pharaohs • Pyramids • Ancient Kingdoms',
    },
    {
      'name': 'Greece',
      'flag': '🇬🇷',
      'description': 'Mycenaean • Classical • Hellenistic',
    },
    {
      'name': 'China',
      'flag': '🇨🇳',
      'description': 'Qin • Han • Ancient Imperial China',
    },
    {
      'name': 'Italy',
      'flag': '🇮🇹',
      'description': 'Roman Empire • Art • Architecture',
    },
    {
      'name': 'Mexico',
      'flag': '🇲🇽',
      'description': 'Aztec • Maya • Mesoamerican Heritage',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final columns = width >= 1000
        ? 3
        : width >= 650
            ? 2
            : 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1150),
              child: Padding(
                padding: EdgeInsets.all(width >= 700 ? 40 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CHOOSE A CIVILIZATION',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 3,
                        color: Color(0xFF8B6F47),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Where will you travel?',
                      style: TextStyle(
                        fontSize: width >= 700 ? 38 : 29,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF302A24),
                      ),
                    ),
                    const SizedBox(height: 35),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: countries.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: width < 650 ? 2.0 : 1.5,
                      ),
                      itemBuilder: (context, index) {
                        final country = countries[index];

                        return _CountryCard(
                          name: country['name']!,
                          flag: country['flag']!,
                          description: country['description']!,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// COUNTRY CARD
// ============================================================

class _CountryCard extends StatelessWidget {
  final String name;
  final String flag;
  final String description;

  const _CountryCard({
    required this.name,
    required this.flag,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArtifactsPage(country: name),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F5EE),
          border: Border.all(
            color: const Color(0xFFD4C5B2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 34),
            ),
            const Spacer(),
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color(0xFF302A24),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF74695F),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'EXPLORE  →',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    color: Color(0xFF8B6F47),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ARTIFACTS PAGE
// ============================================================

class ArtifactsPage extends StatelessWidget {
  final String country;

  const ArtifactsPage({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final artifacts = allArtifacts
        .where((artifact) => artifact.country == country)
        .toList();

    final columns = width >= 950
        ? 3
        : width >= 600
            ? 2
            : 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          country,
          style: const TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1150),
              child: Padding(
                padding: EdgeInsets.all(width >= 700 ? 40 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${artifacts.length} ARTIFACTS',
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 3,
                        color: Color(0xFF8B6F47),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Treasures of $country',
                      style: TextStyle(
                        fontSize: width >= 700 ? 36 : 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF302A24),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: artifacts.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        return _ArtifactCard(
                          artifact: artifacts[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ARTIFACT CARD
// ============================================================

class _ArtifactCard extends StatelessWidget {
  final Artifact artifact;

  const _ArtifactCard({
    required this.artifact,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) {
        return InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtifactDetailsPage(
                  artifact: artifact,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9F5EE),
              border: Border.all(
                color: const Color(0xFFD4C5B2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE AREA
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFE8DED0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5),
                            ),
                            child: Image.network(
                              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                              artifact.image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.museum_outlined,
                                    size: 65,
                                    color: Color(0xFF8B6F47),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Material(
                            color: const Color(0xEFFFFFFF),
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => museumState.toggleFavorite(
                                artifact.name,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  museumState.isFavorite(artifact.name)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 19,
                                  color: const Color(0xFF8B6F47),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // INFORMATION AREA
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artifact.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF302A24),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          artifact.period,
                          style: const TextStyle(
                            fontSize: 11,
                            letterSpacing: 1,
                            color: Color(0xFF8B6F47),
                          ),
                        ),
                        const Spacer(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Color(0xFF8B6F47),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// ARTIFACT DETAILS PAGE
// ============================================================

class ArtifactDetailsPage extends StatelessWidget {
  final Artifact artifact;

  const ArtifactDetailsPage({
    super.key,
    required this.artifact,
  });

  @override
  Widget build(BuildContext context) {
    museumState.markViewed(artifact.name);
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 800;

    return AnimatedBuilder(
      animation: museumState,
      builder: (context, _) => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE6),
        foregroundColor: const Color(0xFF302A24),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Favourite',
            icon: Icon(
              museumState.isFavorite(artifact.name)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: museumState.isFavorite(artifact.name)
                  ? const Color(0xFF8B6F47)
                  : null,
            ),
            onPressed: () => museumState.toggleFavorite(artifact.name),
          ),
          IconButton(
            tooltip: 'Exit to Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 50 : 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LARGE IMAGE
                    Container(
                      width: double.infinity,
                      height: isWide ? 450 : 300,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8DED0),
                        border: Border.all(
                          color: const Color(0xFFD4C5B2),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.network(
                          webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                          artifact.image,

                          // IMPORTANT:
                          // Shows the complete artifact.
                          fit: BoxFit.contain,

                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.museum_outlined,
                                size: 100,
                                color: Color(0xFF8B6F47),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      artifact.country.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 3,
                        color: Color(0xFF8B6F47),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      artifact.name,
                      style: TextStyle(
                        fontSize: isWide ? 45 : 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF302A24),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // FACT BOXES
                    if (isWide)
                      Row(
                        children: [
                          Expanded(
                            child: _FactBox(
                              title: 'PERIOD',
                              value: artifact.period,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _FactBox(
                              title: 'MATERIAL',
                              value: artifact.material,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _FactBox(
                            title: 'PERIOD',
                            value: artifact.period,
                          ),
                          const SizedBox(height: 12),
                          _FactBox(
                            title: 'MATERIAL',
                            value: artifact.material,
                          ),
                        ],
                      ),

                    const SizedBox(height: 35),

                    const Text(
                      'ABOUT THE ARTIFACT',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B6F47),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      artifact.description,
                      style: TextStyle(
                        fontSize: isWide ? 17 : 15,
                        height: 1.8,
                        color: const Color(0xFF51483F),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // EXIT HOME
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                        },
                        icon: const Icon(Icons.home_outlined),
                        label: const Text(
                          'EXIT TO HOME',
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF302A24),
                          side: const BorderSide(
                            color: Color(0xFF8B6F47),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}

// ============================================================
// FACT BOX
// ============================================================

class _FactBox extends StatelessWidget {
  final String title;
  final String value;

  const _FactBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE4D7),
        border: Border.all(
          color: const Color(0xFFD4C5B2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: Color(0xFF8B6F47),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF302A24),
            ),
          ),
        ],
      ),
    );
  }
}
