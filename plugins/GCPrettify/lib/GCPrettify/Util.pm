#############################################################################
# Copyright © 2009 Six Apart Ltd.
# This program is free software: you can redistribute it and/or modify it 
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation, or (at your option) any later version.  
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
# version 2 for more details.  You should have received a copy of the GNU 
# General Public License version 2 along with this program. If not, see 
# <http://www.gnu.org/licenses/>.

package GCPrettify::Util;

sub gcprettify_filter {
    my ( $str, $val, $ctx ) = @_;
    $str =~ s/<code\s*>/<code class="prettyprint">/g;
    return $str;
}

sub patch_html_text_transform {
    no warnings 'redefine';
    my $orig_html_text_transform = &MT::Util::html_text_transform;
    *MT::Util::html_text_transform = sub {
        my $str = shift;
        my $in_pre;
        $str = '' unless defined $str;
        my @paras = split /\r?\n\r?\n/, $str;
        for my $p (@paras) {
            if ($p =~ m|<pre>|) {
                $in_pre = 1;
            }
            if (! $in_pre and $p !~ m@^</?(?:h1|h2|h3|h4|h5|h6|table|ol|dl|ul|menu|dir|p|pre|center|form|fieldset|select|blockquote|address|div|hr)@) {
                $p =~ s!\r?\n!<br />\n!g;
                $p = "<p>$p</p>";
            }
            if ($p =~ m|</pre>|) {
                $in_pre = 0;
            }
        }
        join "\n\n", @paras;
    };
}

1;
