This plugin is no longer supported in Movable Type 8 and later.

# GCPrettify, a plugin for Movable Type

Authors: Six Apart
Copyright: 2009 Six Apart Ltd.
License: [Artistic License 2.0](http://www.opensource.org/licenses/artistic-license-2.0.php)


## Overview

GCPrettify is a plugin designed to allow easy use of [Google Code's `prettify.js` script][1] for syntax highlighting of code samples.

GCPrettify 0.5 uses the May 21, 2009 release of the prettify.js code.

[1]: http://code.google.com/p/google-code-prettify/

## Requirements

* MT4.x


## Features

* Provides the global MT tag modifier `gcprettify` which when set will replace all `<code>` html tags in the output content of the modified MT tag with `<code class="prettyprint">`.

    Any `<code>` html tags with an existing class such as `<code class="my-example">` or `<code class="nopretty">` will not be replaced.

* Alters the default ["Convert Line Breaks" filter][2] by restricting the creation of `<br />` and `<p>` tags within the context of `<pre>` blocks.

[2]: http://www.movabletype.org/documentation/developer/text-filters.html

## Documentation

### Integrate Prettify Functionality

1. Add the Prettify script and style links to the html `<head>` element:

        <link href="<$mt:StaticWebPath$>plugins/GCPrettify/prettify.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<$mt:StaticWebPath$>plugins/GCPrettify/prettify.js"></script>

2. To trigger the styling the `prettyPrint()` javascript function must be called after the html page has loaded. To do this use one of the following methods after including the above scripts:

    * After the `<script>` tag loading the `mt.js` script (which may be in the `<head>` as well) add the following:

            <script type="text/javascript">mtAttachEvent('load', prettyPrint);</script>

    * If using jQuery, add this code after including the jQuery script:

            <script type="text/javascript" charset="utf-8">
                $(document).ready(function() {
                    prettyPrint();
                });
            </script>

3. Update template tags outputting content which will contain `<code>` html tags.

    If `<code>` html tags will be added in the "body" or "extended" of entries, search the Movable Type templates for these tags:

        <$mt:EntryBody$>
        <$mt:EntryExtended$>

    Update these tags with the `gcprettify` attribute and a true value:

        <$mt:EntryBody gcprettify="1"$>
        <$mt:EntryExtended gcprettify="1"$>

    Save the templates.

4. Create a new entry and paste the following code into the body of the entry:

        <pre><code>
        /* calculate nth fibonacci number */
        int fib(int n) {
            if (n < 2)
                return 1;
            return fib(n - 2) + fib(n - 1);
        }
        </code></pre>

5. Publish and view entry.

    The "prettyPrint" JavaScript function called on load will then detect all `<code>` tags with the "prettyprint" class, parse their contents, and the appropriate span elements for syntax highlighting.

    Further details on the operations of this script are available at [the google-code-prettify](http://code.google.com/p/google-code-prettify/) page.

    View the page html source and you'll see that MT has updated the `<code>` html tag with the "prettyprint" class:

        <pre><code class="prettyprint">
        /* calculate nth fibonacci number */
        int fib(int n) {
            if (n < 2)
                return 1;
            return fib(n - 2) + fib(n - 1);
        }
        </code></pre>


### Styling `<code>` HTML Tags in Other Templates

Because the `prettify.js` script will "prettify" any `<code>` tag which has the "prettyprint" class, any `<code>` blocks which have the "prettyprint" class in the published html source code will be "prettified" upon page load.

In index templates manually add the "prettyprint" class to all `<code>` html elements:

    <pre><code class="prettyprint">
    document.write('<b>Hello World</b>');
    </code></pre>


## Installation

1. Move the GCPrettify plugin directory to the MT `plugins` directory.
2. Move the GCPrettify `mt-static` directory to the `mt-static/plugins` directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            GCPrettify/
        mt-static/
            plugins/
                GCPrettify/


## Desired Features

* Blog-level overrides of the default GCPrettify style sheet
* Alteration of "Convert Line Breaks" filtering only within tags affected by the gcprettify tag modifier


## Support

This plugin is not an official Six Apart release, and as such support from Six Apart for this plugin is not available.
