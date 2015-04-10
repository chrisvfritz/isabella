# Isabella

Isabella is my first foray into voice computing. When I'm using my Apple headphones or the Blue Yeti mic in cardioid mode, Isabella does a fantastic job at recognizing commands, but is *a little* over-sensitive. When you're working from home, alone, in silence, then occasionally talk to your computer, it works great! When other people are around or if you start talking to yourself, she'll get over-zealous and tell you jokes you didn't ask for.

## Installation

See [the pocketsphinx-ruby docs](https://github.com/watsonbox/pocketsphinx-ruby#installation) for instructions installing the latest dev versions of [Pocketsphinx](https://github.com/cmusphinx/pocketsphinx) and [Sphinxbase](https://github.com/cmusphinx/sphinxbase).

Once that's done, just `bundle install` to install the relevant Ruby libraries.

## Configuration

This is more complicated than it should be. For speech recognition, we have three different files:

### `config/commands.yml`

This file contains a list of commands that Isabella responds to. Each command contains a regex pattern for matching, then a script that should be run when that command is recognized. For example:

``` yaml
-
  pattern: 'tell me (?:the|a) joke(?: (?:with|about) ?(?:a|the)? ([\w\s]+))?'
  script: sayjoke
```

Each script is assumed to be a `.rb` file residing in the `scripts` directory in the root of the project.

### `config/grammar.gram`

This file contains a grammer of valid language, in [the JSGF format](http://cmusphinx.sourceforge.net/doc/sphinx4/edu/cmu/sphinx/jsgf/JSGFGrammar.html). It defines valid sentences and components that those sentences are made up of. For example:

```
#JSGF V1.0;

grammar isabella;

public <sentence> = hey isabella <command>;

<command> = tell me a joke | tell me <article> joke <joke-preposition> [<article>] <joke-reference>;

<article> = a | the;

<joke-preposition> = with | about;

<joke-reference> =  orion | etymologist | bar | pessimist | funerals;
```

You can find [quite good documentation on the format of this file here](http://cmusphinx.sourceforge.net/doc/sphinx4/edu/cmu/sphinx/jsgf/JSGFGrammar.html). It should also be noted that *every* word included in this file must be defined in the dictionary file, described in the next section.

### `config/dictionary.dic`

This file contains a list of words with pronunciations in North American English, which judging by the source of the library (Carnegie Mellon University) and extremely limited set of phonemes, probably means some kind of north-east US, academic accent that someone decided is the correct/standard/average way for North Americans to speak English. Whatever. It's free! :smiley:

For some reason, instead of using an existing and more complete list of phonemes for recognizing speech, such as the International Phonetic Alphabet, CMU is using a transcription code called Arpabet, which seems to be designed *not* for speech recognition, but for speech *synthesis*. On top of that, CMU supports only a subset of Arpabet's phonemes and also doesn't support its lexical stress markers. Oh well.

Instead of linking to docs showing you how to use this file, I'll save you the time piecing together instructions from several, sometimes contradictory sources and just show you what *actually* works.

To define the pronunciation for a word, just type the word, then a space, then each phoneme in the word separated by a space. For example:

```
hey HH EY
isabella IH Z AA B EH L AA
```

This is a complete list of phonemes you can use:

```
Phoneme  Example  Translation
-------  -------  -----------
AA       odd      AA D
AE       at       AE T
AH       hut      HH AH T
AO       ought    AO T
AW       cow      K AW
AY       hide     HH AY D
B        be       B IY
CH       cheese   CH IY Z
D        dee      D IY
DH       thee     DH IY
EH       Ed       EH D
ER       hurt     HH ER T
EY       ate      EY T
F        fee      F IY
G        green    G R IY N
HH       he       HH IY
IH       it       IH T
IY       eat      IY T
JH       gee      JH IY
K        key      K IY
L        lee      L IY
M        me       M IY
N        knee     N IY
NG       ping     P IH NG
OW       oat      OW T
OY       toy      T OY
P        pee      P IY
R        read     R IY D
S        sea      S IY
SH       she      SH IY
T        tea      T IY
TH       theta    TH EY T AH
UH       hood     HH UH D
UW       two      T UW
V        vee      V IY
W        we       W IY
Y        yield    Y IY L D
Z        zee      Z IY
ZH       seizure  S IY ZH ER
```

All alternate pronunciations must be marked with paranthesized serial numbers starting from (2) for the second pronunciation. The marker (1) is omitted. For example:

```
directing    D AY R EH K T I NG
directing(2) D ER EH K T I NG
directing(3) D I R EH K T I NG
```

## Usage

```
bundle exec rake listen
```

That'll tell Isabella to start listening for commands. Just `Ctrl-C` when you want her to stop.

## Ideas for increasing accuracy

- Use [Sphinxtrain](http://www.speech.cs.cmu.edu/sphinxman/scriptman1.html) to train Isabella for my voice, specifically. It looks like a pain in the butt, so I've been putting it off.
- Figure out a way to implement a test suite. I have a vague idea of how I could right now, but it would involve creating the same wave files I'd need for Sphinxtrain anyway, so I'll probably do that at the same time.
- Use [dual-microphone speech extraction](http://www.dsp.agh.edu.pl/_media/pl:05337185.pdf) to first separate speech from environment noise, *then* feed the result to Pocketsphinx. I imagine this would require two of the same microphone ideally and looks like yet another thing to research, so again, putting it off.
