use Test::More tests => 2;

subtest "should do nothing if not in dry run" => sub {
  {
    package Foo;
    use Moose;
    with 'MooseX::Role::DryRunnable' => { 
      methods => [ qw(bar) ]
    };

    sub bar {
      shift;
      print "Foo::bar @_\n";
    }

    sub is_dry_run { # required !
      0
    }

    sub on_dry_run { # required !

    }

    no Moose;
    1; 
    
    my $foo = Foo->new;
    $foo->bar();
  }
};

subtest "should change the behavior of some modue if in dry run" => sub {
  plan tests => 1;
  ok(0);
};