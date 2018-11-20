# Is it possible to do pass by reference in Perl?
########################################################################################################
# Prepending a variable with a backslash (\) creates a reference:

my $scalar = "this is a scalar";
my @array = qw( this is my array );
my %hash = (
    'this' => 'my',
    'hash' => 'mine',);

print_all(\$scalar, \@array, \%hash);

sub print_all {
    my $scalar_ref = shift;
    my $arr_ref = shift;
    my $hash_ref = shift;

    print "Scalar: ", $$scalar_ref, "\n";
    print "Array: ", join ' ', @$arr_ref, "\n";
    print "Hash: ", each %$hash_ref, "\n";
}
# prints 
#Scalar: this is a scalar
#Array: this is my array
#Hash: thismy
# See perlman:perlref ( https://www.perlmonks.org/?node=perlman%3Aperlref )  for the juicy details.


########################################################################################################
