import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContent extends StatefulWidget {
  const ContactContent({super.key});

  @override
  State<ContactContent> createState() => _ContactContentState();
}

class _ContactContentState extends State<ContactContent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'timayroselloza24@gmail.com',
      queryParameters: {
        'subject': 'Portfolio Contact from $name',
        'body':
            '''
Name: $name
Email: $email

Message:
$message
''',
      },
    );

    await launchUrl(emailUri);
  }

  Future<void> _openLink(String url) async {
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
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
                  'GET IN TOUCH',
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Have a project, opportunity, or idea?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Feel free to reach out. I would be happy to connect with you.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.45),
                ),
              ),

              const SizedBox(height: 80),

              // Contact Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Information
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 25),
                      child: _contactInformation(),
                    ),
                  ),

                  const SizedBox(width: 50),

                  // Contact Form
                  Expanded(flex: 5, child: _contactForm()),
                ],
              ),

              const SizedBox(height: 80),

              // Tagline
              Center(
                child: Text(
                  'THINK. BUILD. INNOVATE.',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 4,
                    color: Colors.white.withOpacity(0.25),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "LET'S CONNECT",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'I am open to internship opportunities, collaborations, '
          'freelance projects, and other technology-related opportunities.',
          style: TextStyle(
            fontSize: 15,
            height: 1.7,
            color: Colors.white.withOpacity(0.55),
          ),
        ),

        const SizedBox(height: 35),

        // Email
        _contactItem(
          icon: Icons.email_outlined,
          title: 'EMAIL',
          value: 'timayroselloza24@gmail.com',
          onTap: () {
            _openLink('mailto:timayroselloza24@gmail.com');
          },
        ),

        const SizedBox(height: 25),

        // Location
        _contactItem(
          icon: Icons.location_on_outlined,
          title: 'LOCATION',
          value: 'Philippines',
        ),

        const SizedBox(height: 35),

        const Text(
          'SOCIALS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFFFFAE00),
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            _socialButton(
              icon: Icons.code_rounded,
              tooltip: 'GitHub',
              url: 'https://github.com/Ftmaroselers',
            ),

            const SizedBox(width: 12),

            _socialButton(
              icon: Icons.camera_alt_outlined,
              tooltip: 'Instagram',
              url: 'https://www.instagram.com/ftma.rnd_/',
            ),

            const SizedBox(width: 12),

            _socialButton(
              icon: Icons.facebook_rounded,
              tooltip: 'Facebook',
              url: 'https://www.facebook.com/ftmaroselers',
            ),
          ],
        ),
      ],
    );
  }

  Widget _contactItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF8B2635).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF8B2635).withOpacity(0.4),
              ),
            ),
            child: Icon(icon, color: const Color(0xFFFFAE00), size: 20),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),

              const SizedBox(height: 5),

              Text(
                value,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SEND A MESSAGE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            _textField(
              controller: _nameController,
              label: 'Your Name',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 18),

            _textField(
              controller: _emailController,
              label: 'Your Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 18),

            _textField(
              controller: _messageController,
              label: 'Your Message',
              icon: Icons.message_outlined,
              maxLines: 5,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFAE00),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'SEND MESSAGE  ↗',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your '
              '${label.toLowerCase().replaceAll('your ', '')}.';
        }

        return null;
      },
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
        prefixIcon: Icon(icon, size: 20, color: Colors.white.withOpacity(0.4)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Color(0xFFFFAE00), width: 1.5),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _openLink(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, size: 19, color: Colors.white.withOpacity(0.65)),
        ),
      ),
    );
  }
}
