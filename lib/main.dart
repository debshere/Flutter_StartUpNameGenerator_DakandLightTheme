// Roll Number: BT19CSE131 Debrupa Nag. Kindly note that i have switched my branch. The prior Roll number was BT19ECE006

//https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/#4
// https://itnext.io/an-easy-way-to-switch-between-dark-and-light-theme-in-flutter-fb971155eefe
//https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2#0
//
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyTheme with ChangeNotifier{//MyTheme class declared globally
  static bool _isDark= false;//default theme state 
  ThemeMode currentTheme(){//returns the theme based on the _isDark value set to true or false
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }
  void switchTheme(){
    _isDark= ! _isDark;
    notifyListeners();//to Call all the registered listeners.
  }
  
}
MyTheme currentTheme=MyTheme();//object of Mytheme type created globally and initiated using constructer

void main() => runApp(MyApp());

class _MyAppState extends State<MyApp>{

  @override 
  void initState(){
      super.initState();
      currentTheme.addListener((){//adds registered listeners. i.e registers listeners
        print('Changes');
        setState(() {});//setState is for setting the theme. setState() causes a rebuild of the widget and it’s descendants.
      });
    } 
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,//removes the Debug banner
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:currentTheme.currentTheme(),
      title: 'Startup Name Generator',
      
      home: RandomWords(),
        
     
    );
  }
}
class MyApp extends StatefulWidget {//Making MyApp a stateful widget
 
  
    @override
  _MyAppState createState() => _MyAppState();
  

}

class _RandomWordsState extends State<RandomWords> {
    

    final List<WordPair> _suggestions = <WordPair>[];  
    final _saved = Set<WordPair>();          
    final TextStyle _biggerFont = const TextStyle(fontSize: 18);
    Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      
      itemBuilder: (BuildContext _context, int i) {
        
        if (i.isOdd) {
          return Divider();
        }

        
        final int index = i ~/ 2;
        
        if (index >= _suggestions.length) {
          
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
    Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
    void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }
    
@override

Widget build(BuildContext context) {
      
   return Scaffold (
      
     floatingActionButton: FloatingActionButton.extended(
       onPressed:(){
         currentTheme.switchTheme();//whenever pressed, 
         //switchTheme function of the instance of Mytheme class named currentTheme object is called
       },
       label:Text('Switch Theme'),
       icon:Icon(Icons.brightness_high),

     ),                   
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
}  
    
  
}
class RandomWords extends StatefulWidget {
 
  
    @override
  _RandomWordsState createState() => _RandomWordsState();
  

}