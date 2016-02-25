migemo = require \./lib/migemo

{hiragana, katakana, hwkatakana, romaji} = require \./lib/mapping

assert = (a, b, check) ->
  if a != b then console.error "failed: #check, #a != #b"
  else console.log "ok: #a == #b"

assert hiragana.length, romaji.length, "roma == hiragana"
assert hiragana.length, katakana.length, "kata == hiragana"
assert hiragana.length, hwkatakana.length, "hwkata == hiragana"

assert (migemo.to-hiragana \panda), \ぱんだ, "panda converts"
assert (migemo.to-katakana \panda), \パンダ, "panda converts"
assert (migemo.to-half-width-katakana \panda), \ﾊﾟﾝﾀﾞ, "panda converts"
assert (migemo.to-hiragana \dana), \だな, "dana converts"
assert (migemo.to-hiragana \hakka), \はっか, "hakka converts"
assert (migemo.to-hiragana \toukyou), \とうきょう, "toukyou converts"
assert (migemo.to-katakana \toukyou), \トウキョウ, "toukyou converts"
assert (migemo.to-half-width-katakana \toukyou), \ﾄｳｷｮｳ, "toukyou converts"
console.log migemo.to-kanji \toukyou
console.log migemo.to-kanji \shizen

console.log migemo.to-regex \toukyou
console.log migemo.to-regex \shizen
console.log migemo.to-hiragana \pand
console.log migemo.to-regex \pand
console.log migemo.to-regex \kouko
console.log migemo.to-regex \kouk
console.log migemo.to-regex \danna
console.log migemo.to-regex \dana
console.log migemo.to-regex \dan
console.log migemo.to-regex \ibara
console.log migemo.to-regex \toge
console.log migemo.to-regex \touge
console.log migemo.to-regex \ho
console.log migemo.to-regex \kan
console.log migemo.to-regex \kai
console.log migemo.to-regex \kai
console.log migemo.to-regex \kai
console.log migemo.to-regex \i
console.log migemo.to-regex \k
console.log migemo.to-regex \k

