import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const CkvPitchApp());
}

class CkvPitchApp extends StatelessWidget {
  const CkvPitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CKV Pitch Presentatie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6200EA),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default clean font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PitchScreen(),
      },
    );
  }
}

class PitchSlideData {
  final String title;
  final String content;
  final IconData icon;
  final List<Color> gradientColors;

  PitchSlideData({
    required this.title,
    required this.content,
    required this.icon,
    required this.gradientColors,
  });
}

class PitchScreen extends StatefulWidget {
  const PitchScreen({super.key});

  @override
  State<PitchScreen> createState() => _PitchScreenState();
}

class _PitchScreenState extends State<PitchScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // Timer variables for the pitch
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isTimerRunning = false;

  final List<PitchSlideData> _slides = [
    PitchSlideData(
      title: 'Onze CKV Pitch',
      content: 'Welkom bij onze presentatie!\n\nVandaag nemen we jullie mee in ons creatieve proces, van de eerste inspiratie tot het uiteindelijke kunstwerk.',
      icon: Icons.palette_outlined,
      gradientColors: [const Color(0xFF4A00E0), const Color(0xFF8E2DE2)],
    ),
    PitchSlideData(
      title: '1. De Inspiratie',
      content: 'Waar begon het allemaal?\n\n• Welke kunstenaar of stroming sprak ons aan?\n• Welk maatschappelijk thema of persoonlijk verhaal zit erachter?\n• Waarom hebben we juist voor deze insteek gekozen?',
      icon: Icons.lightbulb_outline,
      gradientColors: [const Color(0xFFFF416C), const Color(0xFFFF4B2B)],
    ),
    PitchSlideData(
      title: '2. Het Concept',
      content: 'Wat is het idee achter ons werk?\n\n• De hoofdboodschap die we willen overbrengen.\n• De gekozen discipline (bijv. fotografie, schilderkunst, theater, film).\n• Wat willen we dat de kijker voelt of denkt?',
      icon: Icons.architecture,
      gradientColors: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    ),
    PitchSlideData(
      title: '3. Het Proces',
      content: 'Hoe zijn we te werk gegaan?\n\n• Van de eerste schetsen naar de uitvoering.\n• Welke materialen en technieken hebben we gebruikt?\n• Welke uitdagingen kwamen we tegen en hoe hebben we die opgelost?',
      icon: Icons.handyman_outlined,
      gradientColors: [const Color(0xFFF7971E), const Color(0xFFFFD200)],
    ),
    PitchSlideData(
      title: '4. Het Eindresultaat',
      content: 'Onze reflectie op het project.\n\n• Is het geworden wat we in gedachten hadden?\n• Waar zijn we het meest trots op?\n• Wat zouden we een volgende keer anders doen?',
      icon: Icons.auto_awesome,
      gradientColors: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    ),
    PitchSlideData(
      title: 'Vragen?',
      content: 'Bedankt voor jullie aandacht!\n\nZijn er nog vragen over ons concept, het proces of het eindresultaat?',
      icon: Icons.question_answer_outlined,
      gradientColors: [const Color(0xFF1F1C2C), const Color(0xFF928DAB)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _secondsElapsed = 0;
      _isTimerRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    _isTimerRunning ? Icons.timer : Icons.timer_off,
                    size: 20,
                    color: _isTimerRunning ? Colors.greenAccent : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_secondsElapsed),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
              onPressed: _toggleTimer,
              tooltip: _isTimerRunning ? 'Pauzeer timer' : 'Start timer',
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetTimer,
              tooltip: 'Reset timer',
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Text(
                'Slide ${_currentPage + 1} / ${_slides.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return _buildSlide(_slides[index]);
            },
          ),
          
          // Navigation Controls (Left/Right Arrows for Web/Desktop)
          if (_currentPage > 0)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  iconSize: 48,
                  color: Colors.white.withOpacity(0.5),
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _previousPage,
                ),
              ),
            ),
          if (_currentPage < _slides.length - 1)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  iconSize: 48,
                  color: Colors.white.withOpacity(0.5),
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _nextPage,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _currentPage > 0 ? _previousPage : null,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Vorige'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.white.withOpacity(0.1),
                  foregroundColor: Colors.white,
                ),
              ),
              // Progress dots
              Row(
                children: List.generate(
                  _slides.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Volgende'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(PitchSlideData slide) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: slide.gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                slide.icon,
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(height: 32),
              Text(
                slide.title,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  slide.content,
                  style: const TextStyle(
                    fontSize: 28,
                    height: 1.6,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
