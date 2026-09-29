import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectContent extends StatelessWidget {
  const ProjectContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              'FEATURED PROJECT',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
          ),

          Text(
            'A selection of projects I have designed and developed.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 80),

          _sectionTitle('GROUP PROJECTS'),
          const SizedBox(height: 30),

          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: const [
              ProjectCard(
                imagePath: 'assets/geosos.png',
                title: 'GeoSOS',
                role: 'UI/UX Designer • Frontend Developer',
                description: 'A geofencing-based emergency reporting, dispatch, and response tracking system. (Ongoing project)',
                technologies: ['Figma', 'Flutter'],
                projectUrl: 'https://www.figma.com/design/L33Q0qXsTtI8aYI9s0vB87/GeoSOS?node-id=396-3973&m=dev&t=1fG7drysYrfyQgyI-1',
              ),
              ProjectCard(
                imagePath: 'assets/opera.png',
                title: 'OPERA',
                role: 'Game Designer',
                description: 'A first-person horror survival guess the word game developed in Unity.',
                technologies: ['Unity', 'C#', '3D'],
                downloadPath: 'assets/OPERA.zip',
              ),
              ProjectCard(
                imagePath: 'assets/floodcontrol.png',
                title: 'Flood Control',
                role: 'Game Designer',
                description: 'A 2D game project developed using Godot.',
                technologies: ['Godot', 'C#', '2D'],
                projectUrl: 'https://johnweakii.itch.io/flood-control',
              ),
            ],
          ),

          const SizedBox(height: 100),

          _sectionTitle('SOLO PROJECTS'),
          const SizedBox(height: 30),

          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: const [
              ProjectCard(
                imagePath: 'assets/mdn.png',
                title: 'MDN',
                description: 'A digital marketplace designed to connect farmers directly with customers and simplify agricultural product discovery.',
                technologies: ['UI/UX', 'Figma'],
                projectUrl: 'https://www.figma.com/proto/xMqWa5K7cSGzHRYdqdbggq/MDN-Farm?node-id=1-2&p=f&t=E5791ZpzGffIr8Sd-1&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=1%3A2',
              ),
              ProjectCard(
                imagePath: 'assets/car.png',
                title: 'Parked Car Finder',
                description: 'A car-finding platform that helps users discover and compare vehicles based on their preferences.',
                technologies: ['Kotlin', 'Android Studio', 'Google Maps API'],
                projectUrl:
                    'https://github.com/Ftmaroselers/Activity3.1_CarsLocation',
              ),
            ],
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 30,
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
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? role;
  final String description;
  final List<String> technologies;
  final String? projectUrl;
  final String? downloadPath;

  const ProjectCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.role,
    required this.description,
    required this.technologies,
    this.projectUrl,
    this.downloadPath,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _openProject() async {
    final projectUrl = widget.projectUrl;

    if (projectUrl == null || projectUrl.isEmpty) {
      return;
    }

    await launchUrl(Uri.parse(projectUrl), webOnlyWindowName: '_blank');
  }

  Future<void> _downloadProject() async {
    final downloadPath = widget.downloadPath;

    if (downloadPath == null || downloadPath.isEmpty) {
      return;
    }

    await launchUrl(Uri.parse(downloadPath), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final hasDownload = widget.downloadPath != null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => isHovered = true);
      },
      onExit: (_) {
        setState(() => isHovered = false);
      },
      child: GestureDetector(
        onTap: hasDownload ? _downloadProject : _openProject,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: 520,
          height: 430,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF8B2635).withOpacity(isHovered ? 1.0 : 0.5),
                const Color(0xFFFFAE00).withOpacity(isHovered ? 0.9 : 0.25),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B2635)
                    .withOpacity(isHovered ? 0.7 : 0.25),
                blurRadius: isHovered ? 35 : 18,
                spreadRadius: isHovered ? 3 : 1,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_projectImage(), _projectInfo()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
      child: SizedBox(
        width: double.infinity,
        height: 180,
        child: Image.asset(
          widget.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF1A1A1A),
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white54,
                size: 40,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _projectInfo() {
    final hasDownload = widget.downloadPath != null;

    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          if (widget.role != null) ...[
            const SizedBox(height: 5),
            Text(
              widget.role!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFAE00),
              ),
            ),
          ],

          const SizedBox(height: 10),

          Text(
            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.white.withOpacity(0.55),
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.technologies.map(_technologyTag).toList(),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: hasDownload ? _downloadProject : _openProject,
              child: Text(
                hasDownload ? 'DOWNLOAD GAME  ↓' : 'VIEW PROJECT  ↗',
                style: const TextStyle(
                  color: Color(0xFFFFAE00),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _technologyTag(String technology) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(
        technology,
        style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
      ),
    );
  }
}
