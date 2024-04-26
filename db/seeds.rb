# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(
#     email: 'K@k',
#     password: '123123'
# )

# User.create(name: '田中', email: 'b@b', is_active: true, password: 'bbbbbb', introduction:'よろしくお願いします')
# User.create(name: 'ぽめ', email: 'c@c', is_active: true, password: 'cccccc', introduction:'いぬ')
# User.create(name: '佐藤', email: 'd@d', is_active: true, password: 'dddddd', introduction:'aaaa')
# User.create(name: 'suzuki', email: 'e@e', is_active: true, password: 'eeeeee', introduction:'よろしく')
# User.create(name: '加藤', email: 'f@f', is_active: true, password: 'ffffff', introduction:'test')
# User.create(name: 'ねこ', email: 'g@g', is_active: true, password: 'gggggg', introduction:'ねこ')
# User.create(name: 'もち', email: 'h@h', is_active: true, password: 'hhhhhh', introduction:'omochi')
# User.create(name: 'aaaaaaaa', email: 'i@i', is_active: true, password: 'iiiiii', introduction:'aaaaaaaa')
# User.create(name: '米', email: 'j@j', is_active: true, password: 'jjjjjj', introduction:'映画が好き')
# User.create(name: 'tanaka', email: 'l@l', is_active: true, password: 'llllll', introduction:'こんにちは')

Review.create(user_id:'1' , movie_id:'807' , title:'心に残る名作' , comment:'独特な雰囲気と暗く複雑なプロット。刑事コンビが、連続殺人鬼の手がかりを追い求める中で起こる、予測不能な展開に圧倒されました。' , star:'4.5' , spoiler:'false' )
# Review.create(user_id:'2' , movie_id:'807' , title:'面白い' , comment:'何度も見返すほど好きな映画です。' , star:'5' , spoiler:'false' )
Review.create(user_id:'3' , movie_id:'807' , title:'こわい' , comment:'グロテスクな描写が多く、少し苦手でした' , star:'' , spoiler:'false' )

Review.create(user_id:'3' , movie_id:'1096197' , title:'さめかわいい' , comment:'さめが可愛かった' , star:'5' , spoiler:'true' )
Review.create(user_id:'4' , movie_id:'1096197' , title:'アクションがすごい' , comment:'見知らぬ海底でのサメとの遭遇が恐怖を煽る。孤独と絶望が描かれる中、主人公たちの生き残りをかけた戦いが描かれる。' , star:'5' , spoiler:'false' )
Review.create(user_id:'5' , movie_id:'1096197' , title:'サメ映画といえば' , comment:'サメとのバトルシーンが見所。派手なアクションとスリリングな展開で、サメ映画のファンにはたまらない作品。' , star:'4' , spoiler:'true' )
Review.create(user_id:'6' , movie_id:'1096197' , title:'こわい' , comment:'現実的な描写が怖さを増す。深海での恐怖と絶望が鮮明に伝わる。' , star:'4.5' , spoiler:'true' )
Review.create(user_id:'7' , movie_id:'1096197' , title:'鑑賞記録' , comment:'鑑賞記録' , star:'3' , spoiler:'true' )
Review.create(user_id:'8' , movie_id:'1096197' , title:'迫力がすごい' , comment:'映画館でみてよかった' , star:'5' , spoiler:'true' )
Review.create(user_id:'9' , movie_id:'1096197' , title:'うーん' , comment:'海こわい' , star:'3' , spoiler:'true' )
Review.create(user_id:'10' , movie_id:'1096197' , title:'最近の' , comment:'サメ映画ってすごい' , star:'5' , spoiler:'true' )
Review.create(user_id:'11' , movie_id:'1096197' , title:'さめ飼いたい' , comment:'さめが可愛かった' , star:'3' , spoiler:'true' )

Review.create(user_id:'1' , movie_id:'672' , title:'面白い' , comment:'魔法の世界へのさらなる深みを感じさせる傑作。ストーリーの展開やキャラクターの成長が素晴らしい。' , star:'5' , spoiler:'false' , tag:'名作')
Review.create(user_id:'2' , movie_id:'672' , title:'原作ファンにとっても' , comment:'原作ファンにとっても満足のいく内容。細部にまでこだわった映像美と、ホグワーツの不思議な世界を堪能できる。' , star:'4' , spoiler:'true' , tag:'鑑賞記録')
Review.create(user_id:'3' , movie_id:'672' , title:'やっと見た' , comment:'鑑賞記録' , star:'3' , spoiler:'false' , tag:'鑑賞記録')
Review.create(user_id:'4' , movie_id:'672' , title:'鑑賞記録' , comment:'ダークな要素が増した本作は、より緊迫感が増し、サスペンスも一層引き立つ。魔法の世界に新たな謎が追加され、続きが気になる展開。' , star:'5' , spoiler:'true')
Review.create(user_id:'5' , movie_id:'672' , title:'鑑賞' , comment:'面白かった' , star:'3.5' , spoiler:'true' , tag:'ダークファンタジー' )
Review.create(user_id:'6' , movie_id:'673' , title:'音楽が素晴らしい' , comment:'音楽の使い方が素晴らしい。楽曲が物語の緊張感や感動をより一層引き立てている。全体的に、シリーズファンにとっても見逃せない作品' , star:'4.5' , spoiler:'true' , tag:'ダークファンタジー' )
Review.create(user_id:'7' , movie_id:'673' , title:'ダークファンタジー' , comment:'ダークで幻想的な世界観が見事に表現されており、視覚的にも楽しめる。' , star:'4' , spoiler:'false' )
Review.create(user_id:'8' , movie_id:'673' , title:'犬かわいい' , comment:'黒い犬かわいい' , star:'5' , spoiler:'true' )
Review.create(user_id:'9' , movie_id:'673' , title:'鑑賞しました' , comment:'鑑賞したので備忘録代わりのレビュー' , star:'4.5' , spoiler:'false' , tag:'鑑賞記録' )
Review.create(user_id:'10' , movie_id:'673' , title:'2024年鑑賞' , comment:'見ました' , star:'1' , spoiler:'true' )
Review.create(user_id:'12' , movie_id:'673' , title:'よかった' , comment:'原作の雰囲気を忠実に再現しつつも、新たなアプローチで物語を展開。魔法界の不気味さやホグワーツの秘密がより強調されている。' , star:'5' , spoiler:'true' )


Review.create(user_id:'1' , movie_id:'603' , title:'SFの金字塔' , comment:'『マトリックス』は、SF映画の金字塔と呼ぶにふさわしい作品。没入感あふれる世界観と、独創的なアクションシーンが見事に融合している。' , star:'5' , spoiler:'false' )
Review.create(user_id:'2' , movie_id:'603' , title:'面白い' , comment:'SFファン必見の傑作。アクション好きも哲学的な話が好きな人も、幅広い層に楽しめる作品' , star:'4' , spoiler:'true' , tag:'SF鑑賞部')
Review.create(user_id:'3' , movie_id:'603' , title:'今更ですが' , comment:'見ました。' , star:'4' , spoiler:'false' , tag:'アクションガチ勢' )
Review.create(user_id:'4' , movie_id:'603' , title:'1が一番面白い' , comment:'改めて鑑賞したので記録。' , star:'4.5' , spoiler:'false' , tag:'2024年初映画')
Review.create(user_id:'7' , movie_id:'603' , title:'映像すごい' , comment:'時代の割に頑張ってる。' , star:'3' , spoiler:'false' , tag:'おすすめ映画' )
Review.create(user_id:'6' , movie_id:'603' , title:'mita' , comment:'mimasita' , star:'1' , spoiler:'false' , tag:'SF好きにおすすめ')
Review.create(user_id:'8' , movie_id:'603' , title:'aaa' , comment:'The Matrix is a seismic work that shakes the boundary between reality and fiction. Its blend of visual stimulation and philosophical insight leaves a profound impact on the audience.' , star:'3' , spoiler:'true' )
Review.create(user_id:'9' , movie_id:'603' , title:'Matrix' , comment:'This film offers deep insights and reflections to its viewers. Its questioning of human existence and the nature of reality brings new insights with each viewing.' , star:'2.5' , spoiler:'true' )
Review.create(user_id:'10' , movie_id:'603' , title:'よかった' , comment:'やっぱり1が好き' , star:'3' , spoiler:'false' )
Review.create(user_id:'11' , movie_id:'603' , title:'よかった' , comment:'面白かった' , star:'4' , spoiler:'false' )
