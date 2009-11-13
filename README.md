# GCPrettify, a plugin for Movable Type

Authors: Six Apart, Ltd.  
Copyright: 2009 Six Apart, Ltd.  
License: [Artistic License 2.0](http://www.opensource.org/licenses/artistic-license-2.0.php)

## Overview

GCPrettify is a plugin designed to allow easy use of Google Code's prettify.js script for syntax highlighting of code samples.

## Requirements

* MT 4.x

## Features

* Provides a new tag modifier, gcprettify. When given a true value, this modifier will replace all <code> tags in context with <code class="prettyprint">.
Any code tag with an existing class (<code class="my-example">; <code class="nopretty">) will not be altered.
* Alters the default "Convert Line Breaks" filter, restricting creation of <br /> and <p> tags within the context of <pre> blocks for better post-prettification appearance.

## Documentation

To use GCPrettify, add the following to your page's <head> after the <script> tag that loads mt.js:

    <script type="text/javascript" src="<$mt:StaticWebPath$>plugins/GCPrettify/prettify.js"></script>
    <script type="text/javascript">mtAttachEvent('load', prettyPrint);</script>
    <link href="<$mt:StaticWebPath$>plugins/GCPrettify/prettify.css" rel="stylesheet" type="text/css" />
 
Now, add "prettyprint" classes to your <code> tags, either manually or via the gcprettify template modifier.

### Prettification

Suppose <$mt:EntryBody$> yields:

    <pre><code>
    /* calculate nth fibonacci number */
	int fib(int n) {
	    if (n < 2)
	        return 1;
	    return fib(n - 2) + fib(n - 1);
	}
	</code></pre>

<$mt:EntryBody gcprettify="1"$> will yield:

	<pre><code class="prettyprint">
	/* calculate nth fibonacci number */
	int fib(int n) {
	    if (n < 2)
	        return 1;
	    return fib(n - 2) + fib(n - 1);
	}
	</code></pre>

The "prettyPrint" JavaScript function called on load will then detect all <code> tags with the "prettyprint" class, parse their contents, and the appropriate span elements for syntax highlighting. Further details on the operations of this script are available at [the google-code-prettify](http://code.google.com/p/google-code-prettify/) page. GCPrettify 0.5 uses the May 21, 2009 release of the prettify.js code.

## Installation

1. Move the GCPrettify plugin directory to the MT `plugins` directory.
2. Move the GCPrettify mt-static directory to the `mt-static/plugins` directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            GCPrettify/
        mt-static/
            plugins/
                GCPrettify/

More indepth plugin installation instructions: http://tinyurl.com/easy-plugin-install

## Desired Features

* Blog-level overrides of the default GCPrettify style sheet
* Alteration of "Convert Line Breaks" filtering only within tags affected by the gcprettify tag modifier

## Support

This plugin is not an official Six Apart release, and as such support from Six Apart for this plugin is not available.