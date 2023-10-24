# The Docs

The HIFM docs .

## Blocks

### TLDR;

* Each element in HIFM is a block .
* The element's contents must have higher indent from the parent .
* Element's attributes must be on the same indent as the tag name .
* All indenting is done with tabs .

The structure of a HIFM block looks like this :

    .tagName.class1.class2 ID
    attr value
    attr2 value2
        conntents

This is equivalent to the following HTML :

    <tagName class="class1 class2" id="ID"
    attr=value attr2=value2>
        conntents
    </tagName>

### Blocks components

#### Required

* Tag line .

#### Optional

* Attributes .
* Contents .

#### The Tag line

The components of the *Tag line* are :

* Tag name .
* Id shorthand .
* Classes shorthand .

The *Tag name*, *Classes shorthand* and the *Id shorthand* are the components
of the *Tag line* .  The *Tag line* is the defining feature and the only
required component of each block ; Its indent level dictates the end of the
block and the indent level of the other block's components .

A *Tag line* starts with 0 or more tabs followed by a '.' and a *Tag name* .

After the *Tag name* we an have the optional *Classes* and *Id shorthand*
definitions .

Structure of a HIFM *Tag line* :

    .tagName.class1.class2 ID

HTML :

    <tagName class="class1 class2" id="ID">

##### The Classes shorthand

Thanks to CSS (And JS) classes are used A LOT in HTML and because of that HIFM
allows a simpler way of defining number of classes for each element .  You can
define an element's class by just appending a '.' to its tag name and then
appending the class name to it .

Consider a `div` which is in the class `inlined` .
Its *Tag line* would look like this in HIFM : 

    .div.inlined 

HTML :

    <div class=inlined></div>

You can chain up multiple classes after another .

This is a `div` in both the `inlined` and the `margined` class .

    .div.inlined.margined

HTML :

    <div class="inlined margined"></div>

##### The Id shorthand

Like `class`, the `id` attribute is wildly used in HTML for the same reasons .
Again HIFM has a shorthand for defining the `id` attribute .

The *Id shorthand* of an element can be defined as a single word separated by
one or more spaces from the *Tag name* and or the *Classes shorthand* group .

This is a `div` with the `id` of `navbar` in HIFM :

    .div navbar

HTML :

    <div id=navbar>

Another example with a `div` that is in multiple classes and has the `id` of 
`inputcontainer` :

    .div.inlined.margined inputcontainer

HTML :

    <div class="inlined margined" id=inputcontainer>

#### The Attributes

Element attributes in HIFM come __after__ the *Tag line* .
Element attributes must have the same indent as the *Tag line* .
Attributes in HIFM __do not__ use a '=' for assignment .
Each attribute must be on its own line .

Each attribute line starts with a single word if the attribute type is boolean
the story ends here, a single word on a line :

    .input
    checked

HTML :

    <input checked>

If an attribute needs a value assigned to it, the value should come after the 
attribute name separated by one or more spaces .

    .input
    type checkbox
    checked

HTML :

    <input type=checkbox checked>

Another example :

    .meta
    name somedata
    content HI THIS IS SOME METADATA

HTML :

    <meta name=somedate content="HI THIS IS SOME METADATA">

> Note the `id` and the `class` attributes can be used like simple attributes
> if you don't want to use the shorthand version .

		.div
		id navbar
		class margined inlined
		
Is equivalent to :

		.div.margined.inlined navbar

HTML :
		<div class="margined inlined" id=navbar>

#### Contents

Contents of a block start after the attributes and are indented higher than the
*Tag line* and end at the blocks end (When the indent gets higher or equal to
the *Tag line*).

Contents of a block can be text or other elements based on the tags type . 

For example the `style` and `script` tags do not take any child elements .


### Comments

Comments in HIFM are started with a special `.e` tag .
The `.e` tag does not take any attributes, *Classes shorthand* or *Id
shorthand* .

A single line comment looks like this in HIFM :

    .e A comment !

A multi line comment is started with `.e` too :

    .e A multiline
        comment in HIFM
        looks like this

Multi line comments in HIFM are contents of the special `.e` tags and they need
to be indented as such (Indented higher than the *Tag line*) .

> Note you can have __single__ line comments above and below the attribute
> lines . This type of comments wont be transferred to HTML because HTML does
> not support comments inside tags . Example :

    .input
    .e This attribute is for setting the input type to a checkbox
    type checkbox

HTML :

    <input type=checkbox>

### The DOCTYPE 

The DOCTYPE is quite simple in HIFM .

If a line :
* Appears before *any* tags
* Has no indent
* And starts with "!! "

It is a DOCTYPE and all the following text in the line would be transferred to
HTML after the "<!DOCTYPE " string .

Example :

    !! html

HTML :

    <!DOCTYPE html> 

### Syntactic sugar

The `div` tag can be shortened as a single `d` .

    .d paragraphs
        .p 
            sometext

HTML : 

    <div id=paragraphs>
        <p> sometext </p>
    </div>

## Future features 

* An auto `<br>` block 

## Bugs

* Outputted HTMl is poorly formatted .
* No errors/linting .
* The script sometimes does not recognize end of a block . An empty line after each block is recommended and will fix this .
