package TestSchema::Result::Artist;

use Moose;
#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#use MooseX::NonMoose;
use namespace::autoclean;

use DBIx::Class::MooseColumns;

extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('artist');

# used for testing if ->add_column() works (also PK so used to find the row)
has artist_id => (
  isa => 'Int',
  is  => 'rw',
  add_column => {
    is_auto_increment => 1,
  },
);

# used for testing if ->add_column() works
has name => (
  isa => 'Maybe[Str]',
  is  => 'rw',
  add_column => {
    is_nullable => 0,
  },
);

# used to test custom accessor
has title => (
  isa => 'Maybe[Str]',
  is  => 'rw',
  accessor => '_title',
  add_column => {
  },
);

# used for InflateColumn tests
has birthday => (
  isa => 'Maybe[Str]',
  is  => 'rw',
  add_column => {
    data_type => 'date',
  },
);

# used for benchmarking (Moose accessor)
has phone => (
  # no type constraint (to be fair)
  is  => 'rw',
  add_column => {
  },
);

# used for benchmarking (CAG accessor)
has address => (
  isa => 'Maybe[Str]',
  is  => 'rw',
);

__PACKAGE__->add_column( address => {} );

has guess => (
  isa => 'Int',
  is  => 'ro',
  default => sub { int(rand 100)+1 },
);

# silly example (better to do this with a trigger) but i couldn't invent
# anything better :-)
sub title
{
  my ($self, $value) = (shift, @_);

  if (@_ > 0) {
    die "Invalid title" if defined $value && $value ne 'Dr' && $value ne 'Prof';
    return $self->_title($value);
  }
  else {
    return $self->_title;
  }
}

__PACKAGE__->set_primary_key('artist_id');

#TODO why does MooseX::NonMoose makes Test::DBIx::Class break?
#__PACKAGE__->meta->make_immutable if grep { $_ eq 'immutable' } @ARGV;
__PACKAGE__->meta->make_immutable(inline_constructor => 0)
  if grep { $_ eq 'immutable' } @ARGV;

1;
