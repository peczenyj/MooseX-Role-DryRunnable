use Test::More tests => 1;

subtest "should do nothing if not in dry run" => sub {
  plan tests => 1;
  
  {
    package Foo;
    use Moose;
    with 'MooseX::Role::DryRunnable' => { 
      methods => [ qw(bar) ]
    };

    sub bar {
      Test::More::fail(1, "should be called");
    }

    sub is_dry_run { # required !
      0
    }

    sub on_dry_run { # required !

    }

    no Moose;
    1; 
    
    my $foo = Foo->new();
    $foo->bar();
  }
};