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
            duration: const Duration(milliseconds: 500),
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
  final Function child;
  const StaggeredGridView({Key key, this.count, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          count,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: count ~/ 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: child(index),
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

class StaggeredRow extends StatelessWidget {
  final int count;
  final List<Widget> children;
  const StaggeredRow({Key key, this.count, this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Row(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => ScaleAnimation(
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
