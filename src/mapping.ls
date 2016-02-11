# strategy:
# - create an ordered mapping of valid conversions, then greedily convert
# - this is consistent with wapuro requiring "dannna" for "だんな" but accepting "panda" for "ぱんだ"

# basic characters
hiragana = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふふへほまみむめもやゆよらりるれろわをん".split ''
katakana = "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフフヘホマミムメモヤユヨラリルレロワヲン".split ''
hwkatakana = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝ".split ''
romaji = <[ a i u e o ka ki ku ke ko sa si su se so ta ti tu te to na ni nu ne no ha hi fu hu he ho ma mi mu me mo ya yu yo ra ri ru re ro wa wo nn ]>
# small kana
hiragana = hiragana.concat "ぁぃぇぅぉゃゅょっっ".split ''
katakana = katakana.concat "ァィゥェォャュョッッ".split ''
hwkatakana = hwkatakana.concat "ｧｨｩｪｫｬｭｮｯｯ".split ''
romaji = romaji.concat <[xa xi xu xe xo xya xyu xyo xtu xtsu ]>
# shi/chi-combos + hepburn
hiragana = hiragana.concat <[ しゃ し しゅ しょ しゃ し しゅ しょ ちゃ ち ちゅ ちぇ ちょ ちゃ ち ちゅ ちぇ ちょ じゃ じ じゅ じょ じゃ じ じゅ じょ]>
katakana = katakana.concat <[ シャ シ シュ ショ シャ シ シュ ショ チャ チ チュ チェ チョ チャ チ チュ チェ チョ ジャ ジ ジュ ジョ ジャ ジ ジュ ジョ]>
hwkatakana = hwkatakana.concat <[ ｼｬ ｼ ｼｭ ｼｮ ｼｬ ｼ ｼｭ ｼｮ ﾁｬ ﾁ ﾁｭ ﾁｪ ﾁｮ ﾁｬ ﾁ ﾁｭ ﾁｪ ﾁｮ ｼﾞｬ ｼﾞ ｼﾞｭ ｼﾞｪ ｼﾞｬ ｼﾞ ｼﾞｭ ｼﾞｮ ]>
romaji = romaji.concat <[ sha shi shu sho sya si syu syo cha chi chu che cho tya ti tyu tye tyo ja ji ju jo zya zi zyu zyo ]>
# kya/nya etc
hiragana = hiragana.concat <[ きゃ きゅ きょ ぎゃ ぎゅ ぎょ にゃ にゅ にょ ひゃ ひゅ ひょ びゃ びゅ びょ ぴゃ ぴゅ ぴょ みゃ みゅ みょ りゃ りゅ りょ]>
katakana = katakana.concat <[キャ キュ キョ ギャ ギュ ギョ ニャ ニュ ニョ ヒャ ヒュ ヒョ ビャ ビュ ビョ ピャ ピュ ピョ ミャ ミュ ミョ リャ リュ リョ]>
hwkatakana = hwkatakana.concat <[ ｷｬ ｷｭ ｷｮ ｷﾞｬ ｷﾞｭ ｷﾞｮ ﾆｬ ﾆｭ ﾆｮ ﾋｬ ﾋｭ ﾋｮ ﾋﾞｬ ﾋﾞｭ ﾋﾞｮ ﾋﾟｬ ﾋﾟｭ ﾋﾟｮ ﾐｬ ﾐｭ ﾐｮ ﾘｬ ﾘｭ ﾘｮ]>
romaji = romaji.concat <[ kya kyu kyo gya gyu gyo nya nyu nyo hya hyu hyo bya byu byo pya pyu pyo mya myu myo rya ryu ryo ]>
# dakuten
hiragana = hiragana.concat "がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ".split ''
katakana = katakana.concat "ガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポ".split ''
hwkatakana = hwkatakana.concat <[ ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ]>
romaji = romaji.concat <[ ga gi gu ge go za zi zu ze zo da di du de do ba bi bu be bo pa pi pu pe po ]>
# dash + single n (lowest priority)
hiragana = hiragana.concat ["ー" "ん"]
katakana = katakana.concat ["ー" "ン"]
hwkatakana = hwkatakana.concat ["ｰ" "ﾝ"]
romaji = romaji.concat [\- \n ]

export romaji
export hiragana
export katakana
export hwkatakana

get-mappings = ->
  mapped = {}
  for ii from 0 til romaji.length
    mapped[romaji[ii]] = {
      hiragana: hiragana[ii]
      katakana: katakana[ii]
      hwkatakana: hwkatakana[ii]
    }
  return mapped

export mappings = get-mappings!
