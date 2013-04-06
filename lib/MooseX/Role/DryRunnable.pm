use strict;
use warnings;
package MooseX::Role::DryRunnable;

use MooseX::Role::Parameterized;

use namespace::clean -except => 'meta';

our $VERSION = '0.001';

parameter methods => (
  traits  => ['Array'],
  is      => 'ro',
  isa     => 'ArrayRef[Str]',
  default => sub { [] },
  handles => { all_methods => 'elements' },
);

role {
  my $p = shift;
  
  requires 'is_dry_run';
  requires 'on_dry_run';
  
  foreach my $method ($p->all_methods){
    around $method => sub { 
        my $code   = shift;
        my $target = shift;

        die "Target does not MooseX::Role::DryRunnable" 
          unless $target->DOES('MooseX::Role::DryRunnable');

        $target->is_dry_run() 
          ? $target->on_dry_run($method,@_) 
          : $code->($target, @_)  
      }
  }
};

1;
