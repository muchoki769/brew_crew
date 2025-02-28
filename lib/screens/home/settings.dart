import 'package:brew_crew/theme/theme_provider.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 10.0,
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            decoration:
            BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,

              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.only(left:25, top:10, right:25, bottom:10),
            padding: const EdgeInsets.all(25.0),
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                // Consumer<ThemeProvider>(
                //   builder: (context, themeProvider, child) =>
                // Switch(
                //   value: Provider.of<ThemeProvider>(context, listen:false).isDarkMode,
                //   onChanged: (value) =>
                //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                //   activeColor: Colors.blue,
                //
                // ),
                // ),
                 Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) => Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) => themeProvider.toggleTheme(),
                    activeColor: Colors.blue,
                    ),
                    ),

                    ],
            ),
          )

        ],

      )
    );
  }
}
