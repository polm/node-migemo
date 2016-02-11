# this converts a utf8 edict2 to a reading -> word mapping

export read-stdin-as-lines-then = (func) ->
  buf = ''
  process.stdin.set-encoding \utf-8
  process.stdin.on \data, -> buf += it
  process.stdin.on \end, -> func (buf.split "\n" |> no-empty)

no-empty = ->
  it.filter -> it and it.length > 0

reading2kanji = {}

get-reading-pair = (line) ->
  fields = line.split ' '
  kanji = fields.0
  reading = fields.1

  # kanji may have parenthetical notes or semicolons
  # we don't care about alternative kanji (pretty rare, include mazegaki)
  kanji = kanji.split(";").0
  # remove notes too
  kanji = kanji.replace(/\(.*\)/, '').trim!

  # if the first character of the second field isn't a bracket, 
  # the reading is the same as the entry so just skip it
  if reading.0 != \[ then return

  # reading always has brackets, remove them
  reading = reading.substr 1, reading.length - 2
  # also remove alternates and notes
  reading = reading.split(";").0
  reading = reading.replace(/\(.*\)/, '').trim!

  if not reading2kanji[reading]
    reading2kanji[reading] = []
  reading2kanji[reading].push kanji

# input format: dictionary of (hiragana reading -> list of kanji forms)
dict2tree = (dict) ->
  # w is words that match exactly
  # c is children (longer words with this prefix)
  tree = {}
  for key,val of dict
    letters = key.split ''
    lt = tree # local tree
    while letters.length > 0
      head = letters.shift!
      if not lt[head] then lt[head] = {}
      lt = lt[head]
    # got to our end node
    if not lt.w then lt.w = [] # initialize if needed
    lt.w = lt.w.concat val
  return tree

read-stdin-as-lines-then ->
  it.map get-reading-pair
  console.log JSON.stringify dict2tree reading2kanji

