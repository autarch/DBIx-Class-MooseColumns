package MooseX::DBIC::AddColumn;

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;

use MooseX::DBIC::AddColumn::Meta::Attribute;

Moose::Exporter->setup_import_methods( also => 'Moose' );

sub init_meta {
  my ($class, %args) = (shift, @_);

  Moose->init_meta(%args);

  Moose::Util::MetaRole::apply_metaroles(
    for             => $args{for_class},
    class_metaroles => {
      attribute => ['MooseX::DBIC::AddColumn::Meta::Attribute'],
    },
  );

  return $args{for_class}->meta;
}


=head1 NAME

MooseX::DBIC::AddColumn - Lets you write DBIC add_column() definitions as attribute options

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

  package MyApp::Schema

  use Moose;
  use MooseX::NonMoose;
  use namespace::autoclean;

  extends 'DBIx::Class';

  has id => (
    isa => 'Int',
    is  => 'rw',
    add_column => {
      is_auto_increment => 1,
    },
  );

  has foo => (
    isa => 'Str',
    is  => 'rw',
    add_column => {
      data_type => 'datetime'
    },
  );

  has bar => (        # will call __PACKAGE__->add_column({})
    isa => 'Str',
    is  => 'rw',
    add_column => {
    },
  );

  has quux => (       # no __PACKAGE__->add_column() call
    isa => 'Str',
    is  => 'rw',
  );

  __PACKAGE__->meta->make_immutable;

  1;

=head1 DISCLAIMER

This is ALPHA SOFTWARE. Use at your own risk. Features may change.

=head1 DESCRIPTION

This module allows you to put the arguments to
L<DBIx::Class::ResultSource/add_column> right into your attribute definitions
and will automatically call it when it finds an C<add_column> attribute option.
It also replaces the L<DBIx::Class>-generated accessor methods (these are
L<Class::Accessor::Grouped>-generated accessor methods under the hood) with the
L<Moose>-generated accessor methods so that you can use more of the wonderful
powers of L<Moose> (eg. type constraints, triggers, ...).

=head1 SEE ALSO

L<DBIx::Class>, L<Moose>

=head1 AUTHOR

Norbert Buchmüller, C<< <norbi at nix.hu> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-moosex-dbic-addcolumn at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MooseX-DBIC-AddColumn>.  I
will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MooseX::DBIC::AddColumn

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-DBIC-AddColumn>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MooseX-DBIC-AddColumn>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MooseX-DBIC-AddColumn>

=item * Search CPAN

L<http://search.cpan.org/dist/MooseX-DBIC-AddColumn/>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2010 Norbert Buchmüller, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of MooseX::DBIC::AddColumn
