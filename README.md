# Lucky Prefecture: Yumemi iOS junior engineer codecheck

<p align="center">
<img width="253" alt="YUMEMIScreenShotiPhone14ProLight" src="https://github.com/Kota1021/Yumemi_iOS_junior_engineer_codecheck/assets/9388824/eda5eb23-5e89-4b9b-a55f-01d2ac00ef6f">
<img width="253" alt="YUMEMIScreenShotiPhone14ProDark" src="https://github.com/Kota1021/Yumemi_iOS_junior_engineer_codecheck/assets/9388824/60e31c14-8000-4b52-afd0-6417125017fb">
 </p>
 
## 使用ライブラリ
- Alamofire
- SwiftyUserDefaults
- SwiftUI VerticalTabView<br>

 
## UIについて：
私のUI設計において以下の2点を意識しています。

1. 「ユーザーが必要とする情報のみを表示する」
2. 「ユーザーにとって一回のタップは労力である」

1に関しては、ユーザーの注意力は限りある資産であり、注意深く選別された情報のみに配分されるべきだと考えています。
例えば今回の場合、アプリ初回起動時、まだ占い履歴がない状態では、他のページに飛ぶことができないようにしており、使い方がわからないままユーザーがアプリの中で迷子になることを防いでいます。

2に関しては、入力Viewから違うViewに移動する際、UserDefaultsに入力された内容を保持するよう実装しました。
せっかく労力をかけてタップしてくれた内容をもう一度入力させたりしないのが、設計者による思いやりだと考えるためです。
他には、PrefectureViewにおいて、mapやbriefをpopupした際には、スクロールに反応しないようにして、意図しない動作を防ぎ、ストレスの少ない操作性を実現しています。

特徴：

- トップ画面には美しい画像が表示され、ユーザーの好奇心を刺激します。*
- 将来、ゆめみAPIが英語版に対応することを見据えて（！）、UIは英語で作成し、日本語にローカライズしています。
- Dateは文字列に、またはYearMonthDate型（ゆめみAPIの求める構造）を文字列に変換する際にフォーマットをハードコーディングせず、
DateFormatterに変換を任せているため、端末の言語設定に合わせて○年○月○日といった表示や、Jan. 7. 23といった表示を柔軟に切り替えられます。
- 角丸の丸みやTappableなviewの色合いを統一することで、気持ちよさ、わかりやすさを最大限に引き出しています。

これが私が考えるHot,Simple,and Deepです。

###### *今回占いアプリを作成するために、参考として8、9個の占いアプリをインストールし使ってみました。しかし素晴らしいUIだと感じるアプリは無かったため、発想を変え、じゃらんやBolking.comのような旅行アプリを参考にしてみました。例えばトップ画面に美しい写真が表示されるのは、Reluxというアプリから発想を借りました。アプリ起動時に美しい画面を表示するのが素晴らしいと思ったのは、旅行アプリを使用するユーザーは、旅行という手段を通して「日常からの解放」という感覚を求めており、それを擬似的に与えているからです。今回の占いアプリにおいて私が想定したユーザーも、単に「自分の血液型と生年月日からしたら、新潟県が相性最高なんだな！」なんてことを知りたいのではなく、「日本の地理に興味があり、都道府県をちょっと深く知りたい、そして占いも好き」という層です。そこで、APIから得た情報を美しく配置し表示することで、ユーザーの知的好奇心を刺激したいと考えました。

<img width="1280" alt="YUMEMIScreenShotMBA" src="https://github.com/Kota1021/Yumemi_iOS_junior_engineer_codecheck/assets/9388824/aa56ce59-9b4d-4825-a957-20dfbdfdfe9a">

## コーディングについて：
今回のアプリは小規模なのでかっちりとアーキテクチャを決めてはいません。ただしViewとModel、そしてUIロジックが少し複雑になったInputViewにはViewModelを作成し、ロジックを引き剥がしました。
MVVMと異なり、Viewは直接Modelを知っています。ModelはViewを知りません。基本的にViewは画面レイアウト、Model(ViewModel)へのデータの提供に責任を絞っています。
全体を通して、一つの構造には一つの責任のみを持たせる、明瞭な名前で説明できる機能にまで分解する、抽象に依存する、を心がけました。
しかし本格的にアプリ作成を始めて1ヶ月強ですので、まだまだ至らぬ点があるかと思います。ご指摘いただけると大変ありがたいです。

アプリ内で使用している緯度、経度データのprefLatiLong.jsonは、ネットで拾ってきたデータをChatGPTに投げて作成してもらいました。


## 今回困ったこと：
1. 画面遷移とCoreDataへデータ永続化は誰の担当にするべきか、JSONファイルから展開したデータは誰が保持するか、について悩みました。
InputView→PrefectureView(output)<br>
HistoryView→PrefectureView<br>
の遷移は、InputViewとHistoryViewから親viewのContentViewにBindingでフラグを立て、PrefectureViewに遷移してもらっていますが、
これはContentViewの責務に収めていいのか悩みました。ContentViewにもViewModelを作成するべきなのか考えましたがContentViewにもViewModelを作成した場合、
どこで複数のViewModelに同一のModelのインスタンスを渡せばいいものかわかりませんでした。
![IMG_1690の1024リサイズ](https://github.com/Kota1021/Yumemi_iOS_junior_engineer_codecheck/assets/9388824/a2a5aa5e-3900-4b4b-b3bb-024ea1b1faac)

2. JSONファイルデータはstructのstatic propertyに保持し、シングルトン風にしていますが、これが最適なのかは分かりません。 classのシングルトンでない理由は、データの暗黙的な共有は不必要なこと、structの方がより軽量なこと、の2点です。<br> 参考サイト：　https://medium.com/swift-column/singleton-398078bcc58d

4. UIの完成度にこだわり、さまざまなmodifierをつけると可読性が下がりました。見通しを良くするために細かく切り出すと、
逆にボイラープレートが増え分かりずらくなったりし、そのバランスや、そもそも設計が最適なのか悩みました。

5. Macで開いた際、HistoryのScrollViewを矢印キーで左右に移動できるようにしましたが、ネイティブな実装でないので動作が不安定です。
<br>(iOS 17からできるようになるそうです！<br>https://developer.apple.com/documentation/swiftui/view/scrollposition(id:)?changes=latest_minor )

6. CoreData、API、JSONファイルのそれぞれから取得した都道府県データを名前で照合していますが、本来はIDなどで照合したいです。

7. テストコードに初めて挑戦しModelのテストコードはかけた。しかしCoreDataのエンティティをDiskではなくMemory上で展開しUITestをすることで、さまざまなデータを注入してUIを確認したかったので方法を調べたがわからなかった。


## 今回学んだこと：

- Gitのブランチといった概念や、gitのターミナルからの使い方<br>
（https://qiita.com/kota314/items/def463792a9cd9840103 に書きましたが、データを破壊してしまい、復旧のために必死で学習しました。）<br>
- Swift-format<br>
- Safe Areaの概念<br>
- App Strageへの保存<br>
- Viewは、本質的な部分のみをextractし、paddingなどの修飾は呼び出し側でつけると再利用性が高まること。<br>
- Extractしたviewには、最低限の情報のみを与えること。<br>
- 重複したコードは一見するとまとめたいが、重複したままの方が見通しが良いことがあること。<br>
- テストコードを書くこと<br>
- Modelの概念<br>
- Protocol Oriented Programming の概念(ふわっと)<br>
- 抽象に依存すること<br>
- 「コードの臭い」の概念(「iOSアプリ設計パターン入門」より)<br>
- プログラミングは中毒になるくらい楽しいこと。<br>


## 今後したいこと：

- アーキテクチャに対する理解を深める<br>
- SwiftUIを完全に理解する（）<br>
- CoreDataに関する部分もテストする<br>
- エラーハンドリングをより効果的に行う<br>
- Git管理をより効果的に行う<br>
- 簡潔で明瞭な美しいコードを書く<br>


