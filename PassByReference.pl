# Page link https://www.perlmonks.org/?node_id=6758 
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
#Hash: hashmine
# See perlman:perlref ( https://www.perlmonks.org/?node=perlman%3Aperlref )  for the juicy details.

########################################################################################################
#One might argue that Perl always does Pass-By-Reference, but protects us from ourselves.
#@_ holds the arguments passed to a subroutine, and it is common idiom to see something like:

sub mySub{
  my $Arg = shift;
}

sub mySub2{
  my ($Arg) = @_;
}
#Why is that? Why don't we just use the @_ array directly?
#First, there is the laudable goal of more readable code, which is sufficient reason, in itself, 
#to rename variables away from cryptic things like $_[3]. But really, we copy values out of @_ because 
#(from the man page) "its elements are aliases for the actual scalar parameters."

#In short, this means that if you modify an element of @_ in your subroutine, you are also modifying 
#the original argument. This is almost never the expected behavior! Further, if the argument is not
#updatable (like a literal value, or a constant), your program will die with an error like 
#"Modification of a read-only value attempted."

#Consider:
sub test{
  $_[0] = 'New Value';
}

my $Var = 'Hi there';
print "$Var\n";
test ($Var);
print "$Var\n";

#will print out:
#Hi there
#New Value

#So, yes, you can do pass-by-reference in Perl, even without backslashes; but it is almost 
#always better (some would leave out the "almost" in this statement) to make your caller explicitly
#pass you a reference if you intend to modify a value.
########################################################################################################
#In fact, passing by reference is a must to preserve the values in separate data structures, 
#even an array and scalar. For instance:

my @array = qw ( 1 2 3 4 5 );
my $num = 6;

&testsub ( @array, $num );

sub testsub {
   my ( @list, $single ) = @_;
   print @list;
}

#will print:
#123456

#Passing those values via the @_ flattens all values into one long list. However:
my @array = qw ( 1 2 3 4 5 );
my $num = 6;

&testsub ( \@array, $num );

sub testsub {
   my ( $list, $single ) = @_;
   print @$list;
}

#will print:
#12345
#where passing the array by ref will keep the values from all merging into the single list.

