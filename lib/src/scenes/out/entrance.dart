import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import '../../widgets/carousel.dart';

class Entrance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<CarouselModel> items = [
      CarouselModel (
        title: "Çevrendeki yeni ve ilginç insanları keşfet",
        child: Icon(Icons.whatshot, size: 110.0, color: Colors.pink)
      ),
      CarouselModel (
        title: "Bir kişiyi beğenmek için sağa veya pas geçmek için sola kaydır",
        child: Icon(Icons.thumbs_up_down, size: 110.0, color: Colors.pink)
      ),
      CarouselModel (
        title: "Eğer beğendiğin kişi de seni sağa kaydırırsa \"Eşleştiniz\" demektir!",
        child: Icon(Icons.thumb_up, size: 110.0, color: Colors.pink)
      ),
      CarouselModel (
        title: "Sadece eşleştiğin kişiler sana mesaj gönderebilir",
        child: Icon(Icons.chat_bubble_outline, size: 110.0, color: Colors.pink)
      ),
    ];
    return Scaffold (
      body: SafeArea (
        child: Container (
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Flexible (
                child: Carousel(items)
              ),
              Flexible (
                child: Column (
                  children: <Widget> [
                    Container (
                      width: MediaQuery.of(context).size.width / 2,
                      child: RichText (
                        textAlign: TextAlign.center,
                        text: TextSpan (
                          style: TextStyle (
                            color: Colors.grey[400]
                          ),
                          children: <TextSpan> [
                            TextSpan (
                              text: "Oturum Aç'a dokunarak ",
                            ),
                            TextSpan (
                              text: "Hizmet Şartlarımızı",
                              recognizer: TapGestureRecognizer()..onTap = (){
                                print('hizmet şartlarımız');
                              },
                              style: TextStyle (
                                decoration: TextDecoration.underline
                              )
                            ),
                            TextSpan (
                              text: " ve "
                            ),
                            TextSpan (
                              text: "Gizlilik Politikamızı",
                              recognizer: TapGestureRecognizer()..onTap = (){
                                print('gizlilik politikamız');
                              },
                              style: TextStyle (
                                decoration: TextDecoration.underline
                              )
                            ),
                            TextSpan (
                              text: " kabul ediyorsun"
                            )
                          ]
                        )
                      ),
                    ),
                    Container(margin: EdgeInsets.all(5.0)),
                    Container (
                      width: MediaQuery.of(context).size.width * 4 / 5,
                      child: FlatButton (
                        padding: EdgeInsets.all(15.0),
                        color: Color(0xff3b5998),
                        onPressed: () => Navigator.of(context).popAndPushNamed("/main-controller"),
                        shape: StadiumBorder(),
                        child: Text (
                          "FACEBOOK İLE OTURUM AÇ",
                          style: TextStyle (
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(margin: EdgeInsets.all(1.5)),
                    Container (
                      width: MediaQuery.of(context).size.width * 4 / 5,
                      child: FlatButton (
                        padding: EdgeInsets.all(15.0),
                        color: Colors.transparent,
                        onPressed: () => print('y'),
                        shape: StadiumBorder(side: BorderSide(color: Colors.teal[300])),
                        child: Text (
                          "TELEFON NUMARASI İLE OTURUM AÇ",
                          style: TextStyle (
                            color: Colors.teal
                          ),
                        ),
                      ),
                    ),
                    Container(margin: EdgeInsets.all(5.0)),
                    InkWell (
                      onTap: () => print('y'),
                      child: Text (
                        "Oturum açarken sorun mu yaşıyorsun",
                        textAlign: TextAlign.center,
                        style: TextStyle (
                          decoration: TextDecoration.underline,
                          color: Colors.teal[600]
                        ),
                      ),
                    ),
                    Expanded (
                      child: Container (
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row (
                          children: <Widget> [
                            Flexible (
                              child: Text (
                                "Facebook'a hiçbir şey göndermiyoruz.",
                                textAlign: TextAlign.center,
                                style: TextStyle (
                                  color: Colors.grey[400]
                                )
                              ),
                            ),
                            Icon(Icons.arrow_downward, color: Colors.grey[400])
                          ]
                        ),
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}