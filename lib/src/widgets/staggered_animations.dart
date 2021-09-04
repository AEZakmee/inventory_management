import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredListView extends StatelessWidget {
  final int count;
  final Widget child;
  const StaggeredListView({Key key, this.count, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class StaggeredGridView extends StatelessWidget {
  final int count;
  final Widget child;
  const StaggeredGridView({Key key, this.count, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: count,
        children: List.generate(
          100,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: count,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StaggeredColumn extends StatelessWidget {
  final int count;
  final List<Widget> children;
  const StaggeredColumn({Key key, this.count, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: children,
        ),
      ),
    );
  }
}
