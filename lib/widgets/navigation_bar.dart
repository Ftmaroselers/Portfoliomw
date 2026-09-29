import 'package:flutter/material.dart';

class PortfolioNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const PortfolioNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  static const List<String> items = ['HOME', 'PROJECTS', 'CONTACT'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'PatDev.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFFFFAE00),
            ),
          ),

          const Spacer(),

          Row(
            children: List.generate(items.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 30),
                child: _NavItem(
                  title: items[index],
                  selected: currentIndex == index,
                  onTap: () => onItemSelected(index),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NAVIGATION ITEM
// ============================================================

class _NavItem extends StatefulWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.selected || isHovered;

    return MouseRegion(
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
        onTap: widget.onTap,
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : Colors.white54,
              ),
              child: Text(widget.title),
            ),

            const SizedBox(height: 7),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              height: 2,
              width: isActive ? 25 : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF8B2635),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
