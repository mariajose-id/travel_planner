import 'package:flutter/material.dart';
import 'package:travel_planner/shared/widgets/navigation_item.dart';
class AnimatedBottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;
  const AnimatedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });
  @override
  State<AnimatedBottomNav> createState() => _AnimatedBottomNavState();
}
class _AnimatedBottomNavState extends State<AnimatedBottomNav>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    assert(widget.items.isNotEmpty, 'Items list cannot be empty');
    
    return Container(
      height: _calculateNavHeight(context),
      decoration: _buildContainerDecoration(context),
      child: SafeArea(
        child: _buildNavItems(context),
      ),
    );
  }
  double _calculateNavHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.10;
  }
  BoxDecoration _buildContainerDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha:0.1),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
      ],
    );
  }
  Widget _buildNavItems(BuildContext context) {
    return Row(
      children: widget.items.asMap().entries.map((entry) {
        return _buildNavItem(context, entry.key, entry.value);
      }).toList(),
    );
  }
  Widget _buildNavItem(BuildContext context, int index, BottomNavItem item) {
    final isSelected = index == widget.currentIndex;
    
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: () => _handleItemTap(index),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return _buildAnimatedItem(context, item, isSelected, index);
            },
          ),
        ),
      ),
    );
  }
  Widget _buildAnimatedItem(BuildContext context, BottomNavItem item, bool isSelected, int index) {
    if (isSelected) {
      return Transform.scale(
        scale: _scaleAnimation.value,
        child: NavigationItem(
          icon: item.icon,
          label: item.label,
          isSelected: true,
          onTap: () => widget.onTap(index),
        ),
      );
    }
    
    return NavigationItem(
      icon: item.icon,
      label: item.label,
      isSelected: false,
      onTap: () => widget.onTap(index),
    );
  }
  void _handleItemTap(int index) {
    if (index != widget.currentIndex) {
      widget.onTap(index);
      _animationController.reset();
      _animationController.forward();
    }
  }
}
class BottomNavItem {
  final IconData icon;
  final String label;
  const BottomNavItem({
    required this.icon,
    required this.label,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavItem &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          label == other.label;
  @override
  int get hashCode => icon.hashCode ^ label.hashCode;
}
