import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gutenberg_project/Constants.dart';
import 'package:gutenberg_project/Model/books.dart';
import 'package:gutenberg_project/Screens/home.dart';
import 'package:gutenberg_project/Services/bookList.dart';
import 'package:gutenberg_project/Widgets/bookCard.dart';
import 'package:url_launcher/url_launcher.dart';

class Books extends StatefulWidget {
  final category;

  const Books({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  CatalogService catalogService = CatalogService();
  List<Results> results = [];
  String query = '';
  TextEditingController controller = TextEditingController();

  void searchBooks() async {
    var bookData =
        await catalogService.getBooks(widget.category.toString().toLowerCase());
    BooksModel booksFetched = BooksModel.fromJson(bookData);
    setState(() {
      results = booksFetched.results;
    });
  }

  void searchQuery(String query) async {
    var bookData = await catalogService.searchBooks(
        widget.category.toString().toLowerCase(), query);
    BooksModel booksFetched = BooksModel.fromJson(bookData);
    setState(() {
      if (results.isEmpty) results = booksFetched.results;
    });
  }

  BuildContext scaffoldContext;

  @override
  void initState() {
    super.initState();
    searchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          textTheme: Theme.of(context).textTheme,
          toolbarHeight: 175.0,
          elevation: 0.0,
          bottom: PreferredSize(
            child: Column(
              children: [
                ListTile(
                  leading: InkWell(
                    child: SvgPicture.asset('assets/images/Back.svg'),
                    onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyMainPage())),
                  ),
                  title: Text(
                    widget.category,
                    style: kHeadingTwo,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color(0xFFA0A0A0),
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF0F0F6),
                      focusColor: Color(0xFFF0F0F6),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/Search.svg',
                        fit: BoxFit.none,
                      ),
                      suffixIcon: query.isNotEmpty
                          ? InkWell(
                              child: SvgPicture.asset(
                                'assets/images/Cancel.svg',
                                fit: BoxFit.none,
                              ),
                              onTap: () {
                                controller.clear();
                                searchBooks();
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        results.clear();
                        setState(() {
                          query = '';
                        });
                        query = value;
                      });
                      query.isEmpty ? searchBooks() : searchQuery(query);
                    },
                    onSubmitted: (value) {
                      setState(() {
                        results.clear();
                        query = value;
                      });
                      query.isEmpty ? searchBooks() : searchQuery(query);
                    },
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(175),
          ),
        ),
        body: new Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return results.isNotEmpty
              ? GridView.builder(
                  itemCount: results.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (114 / (162 + 75)),
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: BookCard(
                        title: results[index].title,
                        author: results[index].authors.isNotEmpty
                            ? results[index].authors[0].name
                            : '',
                        imgURL: results[index].formats.imageJpeg,
                      ),
                      onTap: () {
                        Formats formats = results[index].formats;
                        showBook(formats);
                      },
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }

  void showBook(Formats formats) {
    if (formats.textHtml != null)
      launch(formats.textHtml);
    else if (formats.textHtmlCharsetIso88591 != null)
      launch(formats.textHtmlCharsetIso88591);
    else if (formats.textHtmlCharsetUsAscii != null)
      launch(formats.textHtmlCharsetUsAscii);
    else if (formats.textHtmlCharsetUtf8 != null)
      launch(formats.textHtmlCharsetUtf8);
    else if (formats.applicationPdf != null)
      launch(formats.applicationPdf);
    else if (formats.textPlain != null)
      launch(formats.textPlain);
    else if (formats.textPlainCharsetIso88591 = null)
      launch(formats.textPlainCharsetIso88591);
    else if (formats.textPlainCharsetUsAscii != null)
      launch(formats.textPlainCharsetUsAscii);
    else
      Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(content: new Text('No viewable version available.')));
  }
}
