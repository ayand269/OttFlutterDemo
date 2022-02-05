import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott_demo/src/Router/route.dart';
import 'package:ott_demo/src/Utils/Arguments.dart';
import 'package:ott_demo/src/components/Banner/HomeBanner.dart';
import 'package:ott_demo/src/components/Card/CategoryCard.dart';
import 'package:ott_demo/src/components/Header/HomeHeader.dart';
import 'package:ott_demo/src/components/Lists/CardListWithTitle.dart';

class Home extends StatelessWidget {
  List bannerData = [1, 2, 3, 4, 5];
  List categoryData = [
    {"image": "cat1.jpg", "title": "Discover"},
    {"image": "cat2.jpg", "title": "Category"},
    {"image": "cat3.jpg", "title": "Subcategory"},
    {"image": "cat1.jpg", "title": "Discover"},
    {"image": "cat2.jpg", "title": "Category"},
    {"image": "cat3.jpg", "title": "Subcategory"},
  ];

  List<Map<String, dynamic>> listData = [
    {
      "image": "list1.jpg",
      "name": "fast and furious hobbs and shaw",
      "type": "Adventure & Full of Action",
      "rating": 5.0,
      "statusBar": 'light',
      "description":
          "In London, Hattie Shaw and her team of MI6 agents attempt to retrieve a programmable supervirus dubbed \"Snowflake\" from techno-terrorist organization Eteon. Brixton Lore, an Eteon operative with cybernetic implants that allow him to perform superhuman feats, arrives and kills all the agents except Hattie, who injects the only dose of Snowflake into herself before escaping. Brixton frames Hattie for killing her team and stealing Snowflake, forcing her to go on the run.",
      "screenshoots": [
        {"image": "https://pbs.twimg.com/media/EJm28SbXYAAb8AA.jpg"},
        {
          "image":
              "https://m.media-amazon.com/images/M/MV5BOTgwMzI5NWMtMWZlMi00MjFkLTg5NGItNDFjMGJlMGYwY2Q4XkEyXkFqcGdeQXVyNjczOTE0MzM@._V1_.jpg"
        },
        {
          "image":
              "https://coldfeet-space.nyc3.digitaloceanspaces.com/wsb/2019/07/Hobbs-and-Shaw-1.jpg"
        },
        {
          "image":
              "https://i.pinimg.com/originals/e6/9d/2d/e69d2d0a09ade934fa0bb181d3967a67.png"
        },
        {
          "image":
              "https://diegocrespoblog.files.wordpress.com/2019/08/hobbs-shaw.jpg?w=1200"
        }
      ]
    },
    {
      "image": "list2.png",
      "name": "lucifer",
      "type": "Mythology & Full of Action",
      "rating": 4.0,
      "statusBar": 'light',
      "description":
          "The series focuses on Lucifer Morningstar, a handsome and powerful angel who was cast out of Heaven for his rebellion. As the Devil, Lucifer tires of the millennia he spent being the Lord of Hell, punishing people. Becoming increasingly bored and unhappy with his life in Hell, he abdicates his throne in defiance of his father (God) and abandons his kingdom for Los Angeles, where he runs his own nightclub called Lux. When he finds himself involved in a murder investigation, he meets the intriguing Detective Chloe Decker. After helping the Los Angeles Police Department (LAPD) solve the case by using his power to manipulate humans into revealing their deepest desires, Lucifer accepts a subsequent invitation to work with Chloe as a consultant to the department, and throughout the series, they encounter all sorts of supernatural beings while solving crimes together and developing their relationship.",
      "screenshoots": [
        {
          "image":
              "http://images6.fanpop.com/image/photos/39500000/Lucifer-1x12-TeamLucifer-Screencaps-lucifer-tv-series-39528604-1912-1072.jpg"
        },
        {
          "image":
              "https://staticr1.blastingcdn.com/media/photogallery/2018/5/23/660x290/b_1200x675/two-new-bonus-episodes-of-lucifer-to-premiere-monday-may-28-on-fox-image-via-series-trailer-mpyoutube-channel-screencap_2006293.jpg"
        },
        {"image": "https://simkl.in/episodes/43/4357214f69c67e547_w.jpg"},
        {
          "image":
              "https://kissthemgoodbye.net/dctvshows/albums/Lucifer/Season%203/Lucifer%20Episode%2008%20Chloe%20Does%20Lucifer/L_S3_E8_0129.jpg"
        }
      ]
    },
    {
      "image": "list3.jpg",
      "name": "Money Heist",
      "type": "Thiller, Robbry & Full of Action",
      "rating": 4.5,
      "statusBar": 'light',
      "description":
          "Set in Madrid, a mysterious man known as the \"Professor\" recruits a group of eight people, who choose city names as their aliases, to carry out an ambitious plan that involves entering the Royal Mint of Spain, and escaping with €984 million. After taking 67 people hostage inside the Mint, the team plans to remain inside for 11 days to print the money as they deal with elite police forces. In the events following the initial heist, the group's members are forced out of hiding and prepare for a second heist, this time on the Bank of Spain, as they again deal with hostages and police forces.",
      "screenshoots": [
        {
          "image":
              "https://i.gadgets360cdn.com/large/Money_Heist_season_5_02_1622784107497.jpeg"
        },
        {
          "image":
              "https://cdn.images.express.co.uk/img/dynamic/20/590x/secondary/Money-heist-vault-1968168.jpg?r=1563528885889"
        },
        {
          "image":
              "https://decider.com/wp-content/uploads/2018/02/money-heist.png"
        },
        {
          "image":
              "https://static2.srcdn.com/wordpress/wp-content/uploads/2020/07/The-Professor-Money-Heist-Cropped.jpg?q=50&fit=crop&w=960&h=500&dpr=1.5"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> popularData = [
    {
      "image": "top1.jpg",
      "name": "G.I. Joe: Retaliation",
      "type": "Adventure & Full of Action",
      "statusBar": 'dark',
      "rating": 5.0,
      "description":
          "Duke leads the G.I. Joe Team to the Korean Demilitarized Zone to find a North Korean defector. Later, Zartan, still impersonating the President of the United States, frames G.I. Joe for stealing nuclear warheads from Pakistan after the death of its President during a civil war, and subsequently eliminates G.I. Joe, which kills Duke and the other Joes, using a military air strike. Heavy machine gunner Roadblock, rookie sniper Flint, and counterintelligence officer Lady Jaye survive the attack by diving into a well, and they return to the US and find original G.I. Joe, General Joseph Colton, who provides them with weapons.",
      "screenshoots": [
        {
          "image":
              "https://rogermooresmovienation.files.wordpress.com/2013/03/joe1.jpg"
        },
        {
          "image":
              "https://i0.wp.com/www.caps.media/201/3-gi-joe-retalliation/full/gi-joe2-movie-screencaps.com-13685.jpg?strip=all"
        },
        {
          "image":
              "http://4.bp.blogspot.com/-feL6Pt70wg8/Tua6zGSOYvI/AAAAAAAAARs/2FNvBx0ZQDc/s1600/joe-mazzello-gi-joe-2-mouse.png"
        },
        {
          "image":
              "https://i.pinimg.com/originals/e6/9d/2d/e69d2d0a09ade934fa0bb181d3967a67.png"
        },
        {
          "image":
              "https://d2cdo4blch85n8.cloudfront.net/wp-content/uploads/2013/01/GI-Joe-Retaliation-Snake-Eyes-Sixth-Scale-Figure-1.jpg"
        }
      ]
    },
    {
      "image": "top2.jpg",
      "name": "The Old Guard",
      "type": "Adventure & Full of Action",
      "rating": 3.0,
      "statusBar": 'dark',
      "description":
          "Andromache \"Andy\" of Scythia, Booker, Joe, and Nicky are centuries-old warriors with unexplained regenerative healing abilities who use their vast experience to work as mercenaries, taking missions that help people. Breaking their rule of never working for the same employers twice, they accept a job from former CIA operative James Copley to rescue a group of kidnapped girls in South Sudan. During the mission, which proves to be a ruse, they are ambushed and killed. After quickly recovering and killing their attackers, they realize that Copley set them up and remotely filmed their regeneration.",
      "screenshoots": [
        {
          "image":
              "https://www.leftoye.com/wp-content/uploads/2020/07/The-Old-Guard-Charlize-Theron.jpg"
        },
        {
          "image":
              "https://theculturednerd.org/wp-content/uploads/2020/07/960x0-1.jpg"
        },
        {
          "image":
              "https://www.kissthemgoodbye.net/movie/albums/The%20Old%20Guard/TOG_0120.jpg"
        },
        {
          "image":
              "https://www.joblo.com/wp-content/uploads/2020/07/theoldguard-fb.jpg"
        }
      ]
    },
    {
      "image": "top3.jpg",
      "name": "the last samurai",
      "type": "Adventure & Full of Action",
      "rating": 4.3,
      "statusBar": 'dark',
      "description":
          "In 1876, Former U.S. Army Captain Nathan Algren, a bitter alcoholic traumatized by the atrocities he committed during the American Indian Wars, is approached by his former commanding officer Colonel Bagley to train the newly created Imperial Japanese Army for a forward-thinking Japanese businessman Omura, who intends to use the army to suppress a Samurai-headed rebellion against Japan's new emperor. Despite his hatred of Bagley for his role in the Indian Wars, an impoverished Algren takes the job for the money, and is accompanied to Japan by his old friend, Sergeant Zebulon Gant. Upon arriving, Algren meets Simon Graham, a British translator knowledgeable about the samurai.",
      "screenshoots": [
        {
          "image":
              "https://tomcruisefan.com/news/wp-content/uploads/2015/02/the-last-samurai-1999.jpg"
        },
        {
          "image":
              "http://images5.fanpop.com/image/photos/24500000/The-Last-Samurai-the-last-samurai-24584825-852-480.jpg"
        },
        {
          "image":
              "https://iv1.lisimg.com/image/2306053/601full-the-last-samurai-%28two--disc-special-edition%29-screenshot.jpg"
        },
        {
          "image":
              "https://64.media.tumblr.com/83b52d77e961b263b3f42dd49fade87f/dd3f4f212d39d327-17/s1280x1920/b01099966711cb784d18c04becb12a9154f2ee80.png"
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //         statusBarColor: Color(Colors.white.value),
    //         /* set Status bar color in Android devices. */

    //         statusBarIconBrightness: Brightness.dark,
    //         /* set Status bar icons color in Android devices.*/

    //         statusBarBrightness:
    //             Brightness.light) /* set Status bar icon color in iOS. */
    //     );
    return Scaffold(
      // backgroundColor: Color(Colors.white.value),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Color.fromRGBO(0, 0, 0, 0)),
          child: Container(
              color: Color(Colors.white.value),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: <Widget>[
                    HomeHeader(),
                    Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      children: [
                        HomeBanner(
                          bannerData: bannerData,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 90,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 5, right: 10),
                            children: categoryData
                                .map((item) => CategoryCard(
                                      imagePath: item['image'],
                                      title: item['title'],
                                    ))
                                .toList(),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        CardListWithTitle(
                          title: "My List",
                          listData: listData,
                          onPress: (data) {
                            Navigator.pushNamed(context, MyRoutes.singleMovies,
                                arguments: SingleMovieArguments(data));
                          },
                        ),
                        CardListWithTitle(
                          title: "Popular on Netflix",
                          listData: popularData,
                          onPress: (data) {
                            Navigator.pushNamed(context, MyRoutes.singleMovies,
                                arguments: SingleMovieArguments(data));
                          },
                        ),
                        CardListWithTitle(
                          title: "Top on Rated",
                          listData: listData,
                          onPress: (data) {
                            Navigator.pushNamed(context, MyRoutes.singleMovies,
                                arguments: SingleMovieArguments(data));
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              ))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.red,
              // height: 50,
              child: SafeArea(
                  child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.blue),
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
