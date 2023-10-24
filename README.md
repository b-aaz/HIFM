# HIFM: HTML Intended For Mortals .

## Why ? 

Typing HTML is unnecessarily difficult .

It can be hard to read if not formatted correctly .

The end tags waste space .

## Why not Haml ?

Haml was made to be used with ruby .

## How does it work ?

`cat yourHIFMfile.hifm | hifm2html.awk > your.html`

*Note :* This program outputs ugly HTML it is recommended to add a HTML
formatted (Like [Tidy](https://www.github.com/htacg/tidy-html5)) at the end of the
pipeline .

*Do not forget the* `chmod +x` *.*

## An Example .

This HIFM code :

    !! html

    .e A comment !
        comments in HIFM start with a .e
    .html
        .head
            .script
                clicked ()
                {
                }
            .style
                p {
                    color: #888888;
                }
                body {
                    background-color: #121888;
                }
                .white {
                    color: #FFFFFF;
                }
                #formdiv {
                    background-color: aqua;
                    border-radius: 10px
                }
                .padded {
                    padding: 1em;
                }
                .inline {
                    display: inline-block;
                } 
        .body
            .h1.white
                HIFM : HTML intended for mortals .
            .p 
                this page was made with HIFM BTW .
            .e This is
                a 
                multi
                line
                comment
            .d.inline.padded formdiv
                .form
                method post
                    .label
                        Password ? :
                    .input
                    name pass
                    type password
                    .br
                    .label
                        User name ? :
                    .input
                    .e You can comment attributes in HIFM .
                    type text
                    name user
                    .br
                    .label
                        Remember ?
                    .input
                    name rem
                    type checkbox

Will be converted to this HTML (After Tidy):

    <!DOCTYPE html>
    <!-- A comment !
    comments in HIFM start with a .e
    -->
    <html>
    <head>
      <script>

      clicked ()
      {
      }
      </script>
      <style>

      p {
      color: #888888;
      }
      body {
      background-color: #121888;
      }
      .white {
      color: #FFFFFF;
      }
      #formdiv {
      background-color: aqua;
      border-radius: 10px
      }
      .padded {
      padding: 1em;
      }
      .inline {
      display: inline-block;
      } 
      </style>
    </head>
    <body>
      <h1 class="white">HIFM : HTML intended for mortals .</h1>
      <p>this page was made with HIFM BTW .</p><!-- This is
    a 
    multi
    line
    comment
    -->
      <div class="inline padded" id="formdiv">
        <form method="post">
          <label>Password ? :</label> <input name="pass" type=
          "password"><br>
          <label>User name ? :</label> <input type="text" name=
          "user"><br>
          <label>Remember ?</label> <input name="rem" type="checkbox">
        </form>
      </div>
    </body>
    </html>

## Docs ?

[What ?](DOCS.md)

## TODOs:

* html2hifm
* Vim syntax files
* Docs ?
