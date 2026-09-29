import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ===============================================================
  // SCROLL ANIMATION
  // ===============================================================

  void _handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final scrollPosition = notification.metrics.pixels;

      if (scrollPosition > 150 && !_controller.isCompleted) {
        _controller.forward();
      }

      if (scrollPosition < 100 && !_controller.isDismissed) {
        _controller.reverse();
      }
    }
  }

  // ===============================================================
  // OPEN SOCIAL LINK
  // ===============================================================

  Future<void> _openSocial(String url) async {
    if (url.startsWith('YOUR_')) {
      return;
    }

    final uri = Uri.parse(url);

    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  // ===============================================================
  // OPEN RESUME
  // ===============================================================

  Future<void> _openResume() async {
    final resumeUrl = Uri.base.resolve('assets/resume.jpg');

    await launchUrl(resumeUrl, webOnlyWindowName: '_blank');
  }
  // ===============================================================
  // SOCIAL BUTTON
  // ===============================================================

  Widget _socialButton({
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _openSocial(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Icon(icon, size: 21, color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }

  // ===============================================================
  // RESUME BUTTON
  // ===============================================================

  Widget _resumeButton() {
    return InkWell(
      onTap: _openResume,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFAE00),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFAE00).withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.description_outlined, size: 19, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'RESUME',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // MAIN BUILD
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _handleScroll(notification);
        return false;
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // =====================================================
            // HERO SECTION
            // =====================================================

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // =================================================
                    // IMAGE + BACKGROUND TEXT
                    // =================================================

                    SizedBox(
                      width: 400,
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          // BACKGROUND TEXT

                          Positioned(
                            left: -70,
                            top: -40,
                            child: Transform.scale(
                              scaleY: 2.0,
                              child: Text(
                                'THINK.BUILD.INNOVATE.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 95,
                                  fontWeight: FontWeight.w900,
                                  height: 0.85,
                                  color: Colors.white.withOpacity(0.06),
                                ),
                              ),
                            ),
                          ),

                          // PROFILE IMAGE GLOW
                          Positioned(
                            left: -105,
                            top: -95,
                            child: Container(
                              width: 410,
                              height: 470,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8B2635)
                                        .withOpacity(0.35),
                                    blurRadius: 50,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // PROFILE IMAGE
                          Positioned(
                            left: -100,
                            top: -90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/formalPic.png',
                                width: 400,
                                height: 460,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 60),

                    // =================================================
                    // HERO TEXT
                    // =================================================
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, I am',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // NAME
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFFFFAE00),
                                Color(0xFFFFD166),
                                Color(0xFF8B2635),
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'Fatima Arnado',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ACCENT LINE
                        Container(
                          width: 75,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFAE00),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFAE00).withOpacity(0.7),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ROLE
                        Text(
                          'Information Technology Student',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),

                        Text(
                          'Aspiring Software Engineer',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // QUOTE
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFFFFAE00),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            '"Faith it till you make it."',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.55),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // =================================================
                        // SOCIAL LINKS + RESUME
                        // =================================================
                        Row(
                          children: [
                            _socialButton(
                              icon: Icons.code,
                              tooltip: 'GitHub',
                              url: 'https://github.com/Ftmaroselers',
                            ),

                            const SizedBox(width: 12),

                            _socialButton(
                              icon: Icons.camera_alt_outlined,
                              tooltip: 'Instagram',
                              url: 'https://www.instagram.com/ftma.rnd_/?hl=en',
                            ),

                            const SizedBox(width: 12),

                            _socialButton(
                              icon: Icons.facebook,
                              tooltip: 'Facebook',
                              url: 'https://www.facebook.com/ftmaroselers',
                            ),
                            const SizedBox(width: 25),

                            _resumeButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // ABOUT SECTION
            // =====================================================
            _buildAboutSection(),

            // =====================================================
            // SKILLS SECTION
            // =====================================================
            _buildSkillsSection(),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // ABOUT SECTION
  // ===============================================================

  Widget _buildAboutSection() {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 110),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: 1100,
                  padding: const EdgeInsets.all(55),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.045),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B2635).withOpacity(0.18),
                        blurRadius: 45,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ABOUT TITLE

                      SizedBox(
                        width: 280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ABOUT',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              width: 65,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFAE00),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFFAE00)
                                        .withOpacity(0.7),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 25),

                            Text(
                              'GET TO KNOW ME',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 60),

                      // ABOUT CONTENT
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I am an Information Technology student '
                              'with a passion for designing and developing '
                              'digital experiences.',
                              style: TextStyle(
                                fontSize: 21,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'I enjoy turning ideas into functional and '
                              'visually engaging applications. My interests '
                              'include UI/UX design, frontend development, '
                              'and exploring new technologies.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.7,
                                color: Colors.white.withOpacity(0.55),
                              ),
                            ),

                            const SizedBox(height: 35),

                            // MINI INFO CARDS
                            Row(
                              children: [
                                _aboutItem(
                                  Icons.design_services_outlined,
                                  'UI / UX',
                                  'Design & Prototyping',
                                ),

                                const SizedBox(width: 20),

                                _aboutItem(
                                  Icons.code_rounded,
                                  'DEVELOPMENT',
                                  'Web & Applications',
                                ),

                                const SizedBox(width: 20),

                                _aboutItem(
                                  Icons.auto_awesome_outlined,
                                  'EXPLORING',
                                  'New Technologies',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  // ===============================================================
  // ABOUT ITEM
  // ===============================================================

  Widget _aboutItem(IconData icon, String title, String description) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.035),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFFFFAE00), size: 25),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Color(0xFFFFAE00),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // SKILLS SECTION
  // ===============================================================

  Widget _buildSkillsSection() {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BASIC SKILLS',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'Technologies and tools I work with.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 60),

                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    _SkillCard(
                      title: 'Flutter',
                      description: 'Mobile & Web Development',
                    ),
                    _SkillCard(title: 'Python', description: 'Programming'),
                    _SkillCard(title: 'Java', description: 'Programming'),
                    _SkillCard(
                      title: 'HTML / CSS',
                      description: 'Frontend Development',
                    ),
                    _SkillCard(
                      title: 'JavaScript',
                      description: 'Web Development',
                    ),
                    _SkillCard(title: 'MySQL', description: 'Database'),
                    _SkillCard(title: 'Figma', description: 'UI / UX Design'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// SKILL CARD
// ===============================================================

class _SkillCard extends StatefulWidget {
  final String title;
  final String description;

  const _SkillCard({required this.title, required this.description});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,

        transform: Matrix4.translationValues(0, isHovered ? -7 : 0, 0),

        width: 220,
        height: 170,

        padding: const EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isHovered ? 0.075 : 0.05),

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: isHovered
                ? const Color(0xFFFFAE00).withOpacity(0.45)
                : Colors.white.withOpacity(0.08),
          ),

          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? const Color(0xFFFFAE00).withOpacity(0.15)
                  : Colors.transparent,
              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isHovered ? const Color(0xFFFFAE00) : Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
