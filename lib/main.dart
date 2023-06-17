import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    print(_isExpanded);
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Bottom Bar'),
      ),
      body: Stack(
        children: [
          Container(
            color: _getBackgroundColor(),
            child: Center(
              child: Text(
                'Content for Tab $_currentIndex',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          if (_isExpanded) ...[
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ],
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isExpanded ? 200 : 0,
              width: 220,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.yellow,
                    Colors.pink,
                    Colors.pink,
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: Column(
                  children: [
                    ListTile(
                        title: Text(
                          "Mood Check in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        trailing: Icon(
                          Icons.heart_broken,
                          color: Colors.white,
                        )),
                    ListTile(
                        title: Text(
                          "Voice note",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        trailing: Icon(
                          Icons.mic,
                          color: Colors.white,
                        )),
                    ListTile(
                        title: Text(
                          "Add Photo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        trailing: Icon(
                          Icons.picture_as_pdf,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.pink,
        child: Container(
          child: BottomAppBar(
            color: Colors.white,
            // notchMargin: 10,

            shape: _isExpanded ? CircularNotchedRectangle() : null,
            child: Container(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      _onTabSelected(0);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _onTabSelected(1);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      _onTabSelected(2);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      _onTabSelected(3);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: _toggleExpansion,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              // padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: FloatingActionButton(
                splashColor: Colors.transparent,
                elevation: 0,
                backgroundColor: Colors.transparent,
                onPressed: _toggleExpansion,
                child: Transform.rotate(
                  angle: _animation.value * 0.5 * 3.141592,
                  child: Icon(
                    _isExpanded ? Icons.close : Icons.add,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Color _getBackgroundColor() {
    switch (_currentIndex) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      default:
        return Colors.white;
    }
  }
}
