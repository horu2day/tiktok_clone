import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "User",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");
  late TabController _tabController;
  bool _isWriting = false;
  //     TabController(length: tabs.length, vsync: this);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void _onSearchChanged(String value) {
    print("Searching from $value");
  }

  void _onSubmitted(String value) {
    print("Submitted $value");
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/594733?s=400&u=51d0a83f972e0f874318c581a91cf0247a927773&v=4"),
                  child: Text('카오'),
                ),
                Gaps.h10,
                Expanded(
                  child: SizedBox(
                    height: Sizes.size44,
                    child: TextField(
                      onTap: _onStartWriting,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size12,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: Sizes.size14,
                            top: Sizes.size12,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: Sizes.size4,
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            if (_isWriting)
                              GestureDetector(
                                onTap: _onStopWriting,
                                child: FaIcon(
                                  FontAwesomeIcons.circleXmark,
                                  size: Sizes.size16,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            isScrollable: true,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size6,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Sizes.size10,
                    mainAxisSpacing: Sizes.size10,
                    childAspectRatio: 9 / 21),
                itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size4),
                          ),
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/placeholder.jpg",
                              image:
                                  "https://scontent-gmp1-1.xx.fbcdn.net/v/t31.18172-8/17017194_263347130756747_7925789519210824998_o.jpg?_nc_cat=101&ccb=1-7&_nc_sid=9267fe&_nc_ohc=VBUOmZtZoRcAX9qiaie&_nc_ht=scontent-gmp1-1.xx&oh=00_AfAtsYzRIqeufEn5H2uxUnpV1oiJpgLdJZUPThsggg5mSQ&oe=642BCF21",
                            ),
                          ),
                        ),
                        Gaps.v10,
                        const Text(
                          "This is a very long caption for my tiktok that im upload just now currently.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: Sizes.size16 + Sizes.size2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v8,
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/594733?s=400&u=51d0a83f972e0f874318c581a91cf0247a927773&v=4"),
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  "My avartar is going to be very long",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size16,
                                color: Colors.grey.shade600,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.5M",
                              )
                            ],
                          ),
                        )
                      ],
                    )),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
