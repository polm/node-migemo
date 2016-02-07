
# strategy:
# - create an ordered mapping of valid conversions, then greedily convert
# - this is consistent with wapuro requiring "dannna" for "だんな" but accepting "panda" for "ぱんだ"

# basic characters
hiragana = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふふへほまみむめもやゆよらりるれろわをん".split ''
katakana = "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフフヘホマミムメモヤユヨラリルレロワヲン".split ''
hwkatakana = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝ".split ''
r-labels = <[ a i u e o ka ki ku ke ko sa si su se so ta ti tu te to na ni nu ne no ha hi fu hu he ho ma mi mu me mo ya yu yo ra ri ru re ro wa wo nn ]>
# small kana
hiragana = hiragana.concat "ぁぃぇぅぉゃゅょっっ".split ''
katakana = katakana.concat "ァィゥェォャュョッッ".split ''
hwkatakana = hwkatakana.concat "ｧｨｩｪｫｬｭｮｯｯ".split ''
r-labels = r-labels.concat <[xa xi xu xe xo xya xyu xyo xtu xtsu ]>
# shi/chi-combos + hepburn
hiragana = hiragana.concat <[ しゃ し しゅ しょ しゃ し しゅ しょ ちゃ ち ちゅ ちぇ ちょ ちゃ ち ちゅ ちぇ ちょ じゃ じ じゅ じょ じゃ じ じゅ じょ]>
katakana = katakana.concat <[ シャ シ シュ ショ シャ シ シュ ショ チャ チ チュ チェ チョ チャ チ チュ チェ チョ ジャ ジ ジュ ジョ ジャ ジ ジュ ジョ]>
hwkatakana = hwkatakana.concat <[ ｼｬ ｼ ｼｭ ｼｮ ｼｬ ｼ ｼｭ ｼｮ ﾁｬ ﾁ ﾁｭ ﾁｪ ﾁｮ ﾁｬ ﾁ ﾁｭ ﾁｪ ﾁｮ ｼﾞｬ ｼﾞ ｼﾞｭ ｼﾞｪ ｼﾞｬ ｼﾞ ｼﾞｭ ｼﾞｮ ]>
r-labels = r-labels.concat <[ sha shi shu sho sya si syu syo cha chi chu che cho tya ti tyu tye tyo ja ji ju jo zya zi zyu zyo ]>
# kya/nya etc
hiragana = hiragana.concat <[ きゃ きゅ きょ ぎゃ ぎゅ ぎょ にゃ にゅ にょ ひゃ ひゅ ひょ びゃ びゅ びょ ぴゃ ぴゅ ぴょ みゃ みゅ みょ りゃ りゅ りょ]>
katakana = katakana.concat <[キャ キュ キョ ギャ ギュ ギョ ニャ ニュ ニョ ヒャ ヒュ ヒョ ビャ ビュ ビョ ピャ ピュ ピョ ミャ ミュ ミョ リャ リュ リョ]>
hwkatakana = hwkatakana.concat <[ ｷｬ ｷｭ ｷｮ ｷﾞｬ ｷﾞｭ ｷﾞｮ ﾆｬ ﾆｭ ﾆｮ ﾋｬ ﾋｭ ﾋｮ ﾋﾞｬ ﾋﾞｭ ﾋﾞｮ ﾋﾟｬ ﾋﾟｭ ﾋﾟｮ ﾐｬ ﾐｭ ﾐｮ ﾘｬ ﾘｭ ﾘｮ]>
r-labels = r-labels.concat <[ kya kyu kyo gya gyu gyo nya nyu nyo hya hyu hyo bya byu byo pya pyu pyo mya myu myo rya ryu ryo ]>
# dakuten
hiragana = hiragana.concat "がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ".split ''
katakana = katakana.concat "ガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポ".split ''
hwkatakana = hwkatakana.concat <[ ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ]>
r-labels = r-labels.concat <[ ga gi gu ge go za zi zu ze zo da di du de do ba bi bu be bo pa pi pu pe po ]>
# dash + single n (lowest priority)
hiragana = hiragana.concat ["ー" "ん"]
katakana = katakana.concat ["ー" "ン"]
hwkatakana = hwkatakana.concat ["ｰ" "ﾝ"]
r-labels = r-labels.concat [\- \n ]

reading2kanji = require \../data/jisho.json

export to-hiragana = (roma) ->
  hira = ''
  while roma.length > 0
    [nh, ro] = get-next-hiragana roma
    hira += nh
    roma = roma.substr ro.length
  return hira

export to-katakana = (roma) ->
  hira-to-kata to-hiragana roma

export to-half-width-katakana = (roma) ->
  hira-to-hwkata to-hiragana roma

export to-kanji = (roma) ->
  hira = to-hiragana roma
  if hira-to-kanji hira
    return hira-to-kanji(hira).join '|'
  else return ''

# assume external interface will primarily take romaji
# internally though hiragana is the canonical form

hira-to-kanji = (hira) ->
  reading2kanji[hira]

hira-to-kata = (hira) ->
  hira.split('').map(-> katakana[hiragana.index-of it] or it).join ''

hira-to-hwkata = (hira) ->
  hira.split('').map(-> hwkatakana[hiragana.index-of it] or it).join ''

export to-regex = (roma) ->
  # assumes case insensitive
  hira = to-hiragana roma
  kata = hira-to-kata hira
  hwkata = hira-to-hwkata hira
  kanji =  hira-to-kanji hira
  regstring = [roma, hira, kata, hwkata].join '|'
  if kanji then regstring += '|' + kanji.join '|'
  return new RegExp(regstring, \i)

get-next-hiragana = (roma) ->
    for ii from 0 til r-labels.length
      ro = r-labels[ii]
      if starts-with roma, ro
        return [hiragana[ii], ro]
    # if we can't find anything - check for sokuon consonant doubling
    if roma.length > 1 and roma.0 == roma.1
      return [ \っ, roma.0 ]
    /*
    # if it's the last character and a consonant, try all completions
    if roma.length == 1 and -1 == "aeiou".index-of roma.0
      out = "["
      for vowel in <[ a i u e o ]>
        index = r-labels.index-of (roma.0 + vowel)
        if -1 < index
          out += hiragana[index]
      if out.length > 1
        return [ out + "]", roma[0] ]
    */
    # total failure, so just pop off the first char
    return [ roma[0], roma[0]]


starts-with = (str, prefix) ->
  prefix == str.substr 0, prefix.length
