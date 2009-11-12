use strict;
use warnings;

use lib 'plugins/GCPrettify/lib', 't/lib', 'lib', 'extlib';
use Test::More tests => 2;
use MT::Test;
use MT;

require_ok('GCPrettify::Util');
ok (MT->component ('GCPrettify'), "Plugin loaded");

