import 'package:flutter/material.dart';
    
    class MyButton extends StatelessWidget {
      // final void Function()? onTap;
      final VoidCallback? onTap;
      final Widget child;


      const MyButton({
        super.key,
        required this.onTap,
        required this.child,
      });
    
      @override
      Widget build(BuildContext context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            // padding: const EdgeInsets.all(5),
            // minimumSize: Size(200, 50), // Set button size
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: child,
          ),
        );
      }
    }
    