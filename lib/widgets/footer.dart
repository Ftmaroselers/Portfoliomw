import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
      ),
      child: Column(
        children: [
          // Brand
          const Text(
            'PatDev.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: Color(0xFFFFAE00),
            ),
          ),

          const SizedBox(height: 12),

          // Tagline
          Text(
            'THINK. BUILD. INNOVATE.',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: Colors.white.withOpacity(0.45),
            ),
          ),

          const SizedBox(height: 28),

          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.code_rounded,
                tooltip: 'GitHub',
                url: 'https://github.com/Ftmaroselers',
                onTap: _openLink,
              ),

              const SizedBox(width: 12),

              _SocialButton(
                icon: Icons.camera_alt_outlined,
                tooltip: 'Instagram',
                url: 'https://www.instagram.com/ftma.rnd_/',
                onTap: _openLink,
              ),

              const SizedBox(width: 12),

              _SocialButton(
                icon: Icons.facebook_rounded,
                tooltip: 'Facebook',
                url: 'https://www.facebook.com/ftmaroselers',
                onTap: _openLink,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Divider
          Container(
            width: 70,
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF8B2635),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 25),

          // Copyright
          Text(
            '© ${DateTime.now().year} Fatima Arnado. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.4),
            ),
          ),

          const SizedBox(height: 8),

          // Built With
          Text(
            'Designed & developed with Flutter',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final String url;
  final Future<void> Function(String url) onTap;

  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.url,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: GestureDetector(
          onTap: () => widget.onTap(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isHovered
                  ? const Color(0xFF8B2635).withOpacity(0.25)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? const Color(0xFF8B2635)
                    : Colors.white.withOpacity(0.1),
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: const Color(0xFF8B2635).withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: Icon(
              widget.icon,
              size: 19,
              color: isHovered ? Colors.white : Colors.white.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
