## MooseX-Role-DryRunnable

For many reasons can be interesting change the behavior of some methods using some configuration. For example, there is a special mode, called "dry run", where we can avoid some instructions (like delete/insert/update data) in order to run the system in the product environment and produce log of any operations.

This module is a Moose Role who require two methods, `is_dry_run` and `on_dry_run`, the first method return true if we are in this mode (reading from a configuration file, command line option or some environment variable) and the second receive the name of the method and the list of arguments. Consider the example below:

	package Foo;
	use Data::Dumper;
	use Moose;

	with 'MooseX::Role::DryRunnable' => { 
	  methods => [ qw(bar) ]
	};

	has dry_run => (is => 'ro', isa => 'Bool', default => 0);

	sub bar {
	  shift;
	  print "Foo::bar @_\n";
	}

	sub is_dry_run { # required !
	  shift->dry_run
	}

	sub on_dry_run { # required !
	  my $self   = shift;
	  my $method = shift;
	  $self->logger("Dry Run method=$method, args: \n", @_);
	}
	
In this case, if we set the attribute `dry_run` to true, instead call the Foo::bar method, we call `on_dry_run` and log the 	