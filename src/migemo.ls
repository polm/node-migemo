{mappings, hiragana, katakana, hwkatakana, romaji} = require \./mapping
reading2kanji = require \../data/jisho.json

export to-hiragana = (roma) ->
  hira = ''
  # don't try to convert singles
  if roma.length == 1
    if roma == "n" then return \ん else return roma
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
  return (hira-to-kanji to-hiragana roma).join \|

export find-in-tree = (reading, tree) ->
  if reading == '' then return [] # don't try empty string
  letters = reading.split ''
  node = tree
  # first find the minimum
  for ll in letters
    try
      node = node[ll]
    catch
      return [] # no such reading in our dict
  if not node then return []
  # now recursive
  q = [node]
  out = []
  while q.length > 0
    cn = q.shift!
    if cn.w then out = out.concat cn.w
    for key, value of cn
      # remember all recursive keys are hiragana
      if key == \w then continue
      q.push value
  return out

export prune = (words) ->
  if words.length == 0 then return []
  words.sort!
  out = [words.shift!]
  while words.length > 0
    head = words.shift!
    if not starts-with head, out[*-1]
      out.push head
  return out

# assume external interface will primarily take romaji
# internally though hiragana is the canonical form

memoize-unary = (f) ->
  cache = {}
  return (a) ->
    if cache[a] then return cache[a]
    cache[a] = f a

hira-to-kanji = memoize-unary (hira) ->
  if reading2kanji[hira]?.rapid
    return reading2kanji[hira].rapid
  # handle split cases specially
  # NOTE: this assumes no brackets in the needle,
  # which is not necessarily safe. 
  if hira[*-1] == \]
    [head, tails] = hira.split(\[)
    tails = tails.substr 0, tails.length - 1 # trim end bracket
    out = []
    for tail in tails
      out = out.concat prune find-in-tree (head + tail), reading2kanji
    return out
  prune find-in-tree hira, reading2kanji

hira-to-kata = (hira) ->
  hira.split('').map(-> katakana[hiragana.index-of it] or it).join ''

hira-to-hwkata = (hira) ->
  hira.split('').map(-> hwkatakana[hiragana.index-of it] or it).join ''

export to-regex = (roma) ->
  # assumes case insensitive
  hira = to-hiragana roma
  # if there's an isolated romaji on the end, strip it to avoid flickering 
  # in interactive search
  hira = hira.replace /[a-z]$/, ''
  if hira == ''
    return new RegExp(roma, \i) # nothing to match with
  kata = hira-to-kata hira
  hwkata = hira-to-hwkata hira
  kanji =  hira-to-kanji hira
  regstring = [roma, hira, kata, hwkata].join '|'
  if kanji.length then regstring += '|' + kanji.join '|'
  return new RegExp(regstring, \i)

get-next-hiragana = (roma) ->
  # if it's an "n" and the last char, include possible expansions
  if roma == "n"
    return ['[んなにぬねの]', roma]
  # longest conversion is 4 (xtsu for example)
  for ll from 4 to 1 by -1
    short = roma.substr 0, ll
    if mappings[short]
      return [mappings[short].hiragana, short]
  # if we can't find anything - check for sokuon consonant doubling
  if roma.length > 1 and roma.0 == roma.1
    return [ \っ, roma.0 ]
  # if it's the last character and a consonant, try all completions
  if roma.length == 1 and -1 == "aeiou".index-of roma.0
    out = "["
    for vowel in <[ a i u e o ]>
      index = romaji.index-of (roma.0 + vowel)
      if -1 < index
        out += hiragana[index]
    if out.length > 1
      return [ out + "]", roma[0] ]
  # total failure, so just pop off the first char
  return [roma[0], roma[0]]

starts-with = (str, prefix) ->
  prefix == str.substr 0, prefix.length
