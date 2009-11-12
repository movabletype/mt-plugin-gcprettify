use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 5;
use MT::Test qw( :db );
use MT;
use MT::Blog;

my $blog = MT::Blog->load(1);

my $ctx = new MT::Template::Context;
$ctx->stash( 'blog', $blog );
my $test_txt = '<mt:section gcprettify="1"><code># foo;</code></mt:section>';
my $tmpl = MT::Template->new();
$tmpl->text($test_txt);
$tmpl->blog_id( $blog->id );
$tmpl->save;
is ($tmpl->build($ctx), '<code class="prettyprint"># foo;</code>',
    'gcprettify="1" forces prettification of <code> tags');

$test_txt = '<mt:section gcprettify="1"><code class="other"># foo;</code></mt:section>';
$tmpl = MT::Template->new();
$tmpl->text($test_txt);
$tmpl->blog_id( $blog->id );
$tmpl->save;
is ($tmpl->build($ctx), '<code class="other"># foo;</code>',
    '<code> tags with defined classes are not given prettification');

$test_txt = '<mt:section gcprettify="1"><code      ># foo;</code></mt:section>';
$tmpl = MT::Template->new();
$tmpl->text($test_txt);
$tmpl->blog_id( $blog->id );
$tmpl->save;
is ($tmpl->build($ctx), '<code class="prettyprint"># foo;</code>',
    'Prettification ignores whitespace in <code> tags');

$test_txt = '<mt:section><code># foo;</code></mt:section>';
$tmpl = MT::Template->new();
$tmpl->text($test_txt);
$tmpl->blog_id( $blog->id );
$tmpl->save;
is ($tmpl->build($ctx), '<code># foo;</code>',
    'Non-gcpretty-filtered templates are unchanged');

$test_txt = '<mt:section gcprettify="1"><pre># foo;</pre></mt:section>';
$tmpl = MT::Template->new();
$tmpl->text($test_txt);
$tmpl->blog_id( $blog->id );
$tmpl->save;
is ($tmpl->build($ctx), '<pre># foo;</pre>',
    'Non-<code> tags are unchanged');
