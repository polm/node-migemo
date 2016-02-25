# node-migemo

This is a re-implementation of [migemo](http://0xcc.net/migemo/) in NodeJS. Migemo is a tool for generating regular expressions for Japanese based on romaji input. Wapuro style input (and therefore most of Kunreishiki and Hepburn) is supported.

![migemo demo using searchy](http://i.imgur.com/iAxM94P.gif)

Unlike other migemos, the dictionary is based on Edict2, not SKK, which solves some problems but creates others.

To start using it right away, install together with [searchy](https://www.npmjs.com/package/searchy).

    npm install -g node-migemo searchy

# License

The code I have written is released under the WTFPL, do as you like. **However, please note the dictionary file is based on edict2 and subject to its terms.** I understand this as basically CC-BY-SA-3.0, but please see [here](http://www.edrdg.org/jmdict/edict.html). 

# Other Versions

There are many other implementations of migemo. Besides the [original](http://0xcc.net/migemo/) Ruby version you may also be interested in [this browser-friendly JS version](https://github.com/wakaba/migemojs). 

For reference here are the other implementations I'm aware of:

- todesking [js version](http://www.todesking.com/js_migemo/migemo.html)
- Old River [js version](http://www.oldriver.org/jsmigemo/)
- [c/migemo](https://github.com/koron/cmigemo)
- [XUL/Migemo](https://piro.sakura.ne.jp/xul/_xulmigemo.html) for Firefox & Thunderbird
- [Migemo for Chrome](https://chrome.google.com/webstore/detail/migemo-server-for-google/dfccgbheolnlopfmahkcjiefggclmadb?hl=ja)
