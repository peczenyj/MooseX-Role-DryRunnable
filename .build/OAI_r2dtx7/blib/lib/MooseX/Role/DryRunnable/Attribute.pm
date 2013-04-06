use strict;
use warnings;
package MooseX::Role::DryRunnable::Attribute;
use Moose::Util;
use Attribute::Handlers;

sub UNIVERSAL::dry_it :ATTR(CODE) { 
  my $package = shift;
  my $glob    = shift;
  my $method  = *{$glob}{NAME};
  
  Moose::Util::add_method_modifier($package => around => [ $method => sub { 
      my $code   = shift;
      my $target = shift;

      die "Should be MooseX::Role::DryRunnable" 
        unless $target->DOES('MooseX::Role::DryRunnable');

      $target->is_dry_run() 
        ? $target->on_dry_run($method,@_) 
        : $code->($target, @_)
      }
  ]);
}

1;