import 'package:app/GiftCardPurchaseScreen.dart';
import 'package:app/model/GiftCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

// 충전 - 상품권 구매 Screen
class _PurchaseScreenState extends State<PurchaseScreen> {
  bool _isFavoriteActivate = false;
  bool _isAllGiftCardActivate = false;
  List<GiftCard> giftCards = <GiftCard>[
    GiftCard("images/k1_giftcard.png", "강원상품권", "강원지역 경제 활성화를 위한 모바일 강원상품권", true),
    GiftCard("images/k1_giftcard.png", "춘천사랑상품권", "춘천 경제 활성화를 위한 모바일 춘천상품권", true),
    GiftCard("images/k1_giftcard.png", "한우 사랑 상품권", "한우를 사랑하는 사람을 위한 모바일 상품권", false),
    GiftCard("images/k1_giftcard.png", "---", "~~~", false),
    GiftCard("images/k1_giftcard.png", "---", "~~~", false),
  ];
  List<GiftCard> favorites = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0, 70, 20, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)
                    ),
                    Text(
                      "Buying GiftCard".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                  ],
                )
            ),

            // 즐겨찾기
            CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bookmark".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      ),

                      Icon(
                        _isFavoriteActivate ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                onPressed: (){
                  // 즐겨찾기 리스트 펼치기
                  setState(() {
                    _isFavoriteActivate = !_isFavoriteActivate;
                  });
                }
            ),

            Divider(
              thickness: 1,
            ),


            // 즐겨찾기 리스트
            Visibility(
                visible: _isFavoriteActivate,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: giftCards.length,
                      itemBuilder: (BuildContext context, int index){
                        if(giftCards[index].isFavorite) { // 즐찾 되어있는 것만 가져올거임
                          return Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: GiftCardItems(
                                giftCards[index],
                                    (card) {
                                  // 즐찾 아이콘 클릭이벤트
                                  setState(() {
                                    giftCards[index].isFavorite = !giftCards[index].isFavorite;
                                  });
                                },
                              )
                          );
                        }
                      }
                  )
                ),
            ),

            // 전체 상품권
            CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Entire GiftCard".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      ),

                      Icon(
                        _isAllGiftCardActivate ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        size: 30,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                onPressed: (){
                  // 전체 상품권 리스트 펼치기
                  setState(() {
                    _isAllGiftCardActivate = !_isAllGiftCardActivate;
                  });
                }
            ),

            Divider(
              thickness: 1,
            ),

            // 전체 상품권 리스트
            Visibility(
              visible: _isAllGiftCardActivate,
              child: Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: giftCards.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: GiftCardItems(
                              giftCards[index],
                              (card) {
                                // 즐찾 아이콘 클릭이벤트
                                setState(() {
                                  giftCards[index].isFavorite = !giftCards[index].isFavorite;
                                });
                              },
                            )
                        );
                      }
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftCardItems extends StatefulWidget {
  late GiftCard card;
  late Function(GiftCard card) tappedStar = (GiftCard card) {};

  GiftCardItems(GiftCard card, Function(GiftCard) tappedStar) {
    this.card = card;
    this.tappedStar = tappedStar;
  }

  @override
  State<GiftCardItems> createState() => _GiftCardItemsState();
}

class _GiftCardItemsState extends State<GiftCardItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -5,
                blurRadius: 10,
                offset: Offset(0,3)
            )
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                widget.tappedStar(this.widget.card);
                // setState(() {
                //   this.widget.card.isFavorite = !this.widget.card.isFavorite;
                // });
              },
              child: Icon(
                this.widget.card.isFavorite ? Icons.star : Icons.star_border,
                size: 20,
              ),
            ),
          ),
          Image.asset(
            "${widget.card.image}",
            width: 50,
            height: 50,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "${widget.card.title}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${widget.card.description}",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )

                ],
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60
                ),
                onPressed: () {
                  // 상품권 구매 클릭
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GiftCardPurchaseScreen())
                  );
                },
                child: Text(
                  "Purchase".tr,
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}


