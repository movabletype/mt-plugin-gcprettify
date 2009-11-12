use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 5;
use MT::Test qw( :db :app );
use MT;
use MT::Blog;

my $MT = new MT;
my ( $blog, $entry, $tmpl, $ctx );
my $dummy_text = q{It was a dark and stormy night.
Suddenly, a shot rang out!

A door slammed. The maid screamed.

Suddenly, a pirate ship appeared on the horizon.};
my $transformed_text = q{<p>It was a dark and stormy night.<br />
Suddenly, a shot rang out!</p>

<p>A door slammed. The maid screamed.</p>

<p>Suddenly, a pirate ship appeared on the horizon.</p>};
$blog = MT::Blog->load(1);
$entry = MT::Entry->new();
$entry->set_values({
        blog_id        => 1,
        title          => 'A Rainy Day',
        text           => $dummy_text,
        excerpt        => 'A story of a stroll.',
        created_on     => '19780131074500',
        authored_on    => '19780131074500',
        modified_on    => '19780131074600',
        authored_on    => '19780131074500',
        author_id      => 1,
        status         => MT::Entry::RELEASE(),
    }
); 
$entry->id(1);
$entry->save or die $entry->errstr;
$tmpl = MT::Template->new();
$tmpl->text(q{<$mt:entrybody$>});
$tmpl->blog_id( $blog->id );
$tmpl->save;

$ctx = new MT::Template::Context;
$ctx->stash( 'blog', $blog );
$ctx->stash( 'entry', $entry );
is ($tmpl->build($ctx), $dummy_text,
    q{unfiltered line breaks are not transformed});

$blog->convert_paras(q{__default__});
$blog->save();
$ctx->stash( 'blog', $blog );
is ($tmpl->build($ctx), $transformed_text,
    q{convert_breaks works normally with no <pre> involved});

$entry->text(qq{<pre>$dummy_text</pre>});
$entry->save;
$ctx->stash( 'entry', $entry );
is ($tmpl->build($ctx), qq{<pre>$dummy_text</pre>},
    q{<pre> prevents convert_line_breaks filter from converting linebreaks});

$entry->text(qq{<pre>$dummy_text</pre>

As he touched her hand, she sighed.

And they lived happily ever after.
THE END});
$entry->save;
$ctx->stash( 'entry', $entry );
is ($tmpl->build($ctx), qq{<pre>$dummy_text</pre>

<p>As he touched her hand, she sighed.</p>

<p>And they lived happily ever after.<br />
THE END</p>},
    q{linebreak filter resumes after </pre>\n\n});

my $all_filters = $MT->all_text_filters;
SKIP: {
    skip "Markdown unavailable", 1 unless $all_filters->{markdown};
    $blog->convert_paras('markdown');
    $entry->text(qq{Suddenly, a pirate ship appeared on the horizon.
        
    As he touched her hand, she sighed.

    And they lived happily ever after.
   
THE END});
    $transformed_text = q{<p>Suddenly, a pirate ship appeared on the horizon.</p>

<pre><code>As he touched her hand, she sighed.

And they lived happily ever after.
</code></pre>

<p>THE END</p>
};
    $blog->save();
    $ctx->stash( 'blog', $blog );
    is ($tmpl->build($ctx), $transformed_text,
        q{Callback does not affect Markdown filter});
};