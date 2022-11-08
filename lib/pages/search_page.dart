
import 'package:flutter/material.dart';
import 'package:my_app/widget/search_bar.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {

  final bool? hideLeft;
  final String searchUrl;
  final String? keyword;
  final String? hint;

  const SearchPage ({Key? key,
    this.hideLeft = true,
    this.searchUrl = URL,
    this.keyword,
    this.hint}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
        ],
      )
    );
  }

  get _appBar {
   return Column(
     children: [
       Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             //AppBar渐变遮罩背景
             colors: [Color(0x66000000), Colors.transparent],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
           ),
         ),
         child: Container(
           padding: const EdgeInsets.only(top: 60),
           height: 110,
           decoration: const BoxDecoration(color: Colors.white),
           child: SearchBar(
             hideLeft: widget.hideLeft,
             defaultText: widget.keyword,
             hint: widget.hint,
             speakClick: _jumpToSpeak,
             rightButtonClick: () {
               FocusScope.of(context).requestFocus(FocusNode());
             },
             leftButtonClick: () {
               FocusScope.of(context).requestFocus(FocusNode());
               Navigator.pop(context);
             },
             onChanged: _onTextChanged,
           ),
         ),
       )
     ],
   );
  }

  void _jumpToSpeak() {
  }

  void _onTextChanged(String value) {
  }
}
