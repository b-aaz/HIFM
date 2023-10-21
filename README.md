# HIFM: HTML Intended For Mortals .

## Why ? 

Writing HTML is unnecessarily difficult .
It can be hard to read if not formatted correctly .
The end tags waist space .

## Why not Haml ?

Haml was made to be used with ruby .

## How does it work ?

`cat yourHIFMfile.HIFM | hifm2html.awk > your.html`

*Note :* This program outputs ugly HTML it is recommended to add a HTML
formatted (Like [Tidy](https://www.github.com/htacg/tidy-html5)) at the end of the
pipeline .

*Do not forget the* `chemod +x` *.*

## An Example .

This HIFM code :

    !! html

    .html
        .head
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
            ...inline.padded formdiv
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
    <html>
    <head>
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
      <p>this page was made with HIFM BTW .</p>
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

What ?

## TODOs:

* Comments
* html2hifm
* Docs ?